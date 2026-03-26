#!/usr/bin/env node
/**
 * Check internal links in markdown files.
 *
 * Usage:
 *     node check-links.mjs file1.md file2.md ...
 *
 * Checks all relative markdown links and content-ref links point to existing files.
 * Skips external links (https://), anchor-only links (#section), and mailto links.
 *
 * Exit code 0 if all links are valid, 1 if any are broken.
 */

import { readFileSync, existsSync } from "fs";
import { dirname, join, normalize } from "path";

const MARKDOWN_LINK = /\[([^\]]*)\]\(([^)#\s]+?)(?:#[^)]*)?\)/g;
const CONTENT_REF = /content-ref url="([^"]+)"/g;
const SKIP_PREFIXES = ["http://", "https://", "mailto:", "#"];
// GitBook hosts assets externally — these paths don't exist in the repo
const SKIP_PATHS = [".gitbook/assets/"];

function checkFile(filepath) {
  const broken = [];
  const filedir = dirname(filepath);
  const content = readFileSync(filepath, "utf-8");
  const lines = content.split("\n");

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    const lineno = i + 1;

    for (const m of line.matchAll(MARKDOWN_LINK)) {
      const target = m[2];
      if (SKIP_PREFIXES.some((p) => target.startsWith(p))) continue;
      const resolved = normalize(join(filedir, target));
      if (SKIP_PATHS.some((s) => resolved.includes(s))) continue;
      if (!existsSync(resolved)) {
        broken.push({ lineno, target, resolved });
      }
    }

    for (const m of line.matchAll(CONTENT_REF)) {
      const target = m[1];
      if (SKIP_PREFIXES.some((p) => target.startsWith(p))) continue;
      const resolved = normalize(join(filedir, target));
      if (SKIP_PATHS.some((s) => resolved.includes(s))) continue;
      if (!existsSync(resolved)) {
        broken.push({ lineno, target, resolved });
      }
    }
  }

  return broken;
}

const files = process.argv.slice(2);

if (files.length === 0) {
  console.log("Usage: node check-links.mjs file1.md file2.md ...");
  process.exit(2);
}

const allBroken = new Map();

for (const filepath of files) {
  if (!existsSync(filepath)) continue;
  const broken = checkFile(filepath);
  if (broken.length > 0) {
    allBroken.set(filepath, broken);
  }
}

if (allBroken.size > 0) {
  let total = 0;
  for (const broken of allBroken.values()) total += broken.length;
  console.log(`Found ${total} broken link(s) in ${allBroken.size} file(s):\n`);
  for (const [filepath, broken] of allBroken) {
    for (const { lineno, target } of broken) {
      console.log(`  ${filepath}:${lineno} -> ${target}`);
    }
  }
  process.exit(1);
} else {
  console.log(`All internal links OK (${files.length} files checked)`);
}
