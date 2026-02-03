---
description: Learn how to set up your CI/CD pipeline to include more than 1 target environment.
---

# Advanced Setup: Deploy to multiple targets

The sample will enable you to work on two different branches, where each of the branches deploys to a different environment.

{% hint style="info" %}
With the CI/CD flow, you can trigger deployments to multiple environments simultaneously.

If a deployment is already in progress to a named environment, it will not be possible to trigger another until the first is done.
{% endhint %}

{% tabs %}
{% tab title="Azure DevOps" %}

1. Replace the `azure-release-pipeline.yaml` with the file called `azure-release-pipeline-more-targets.yaml`. It's okay to rename `azure-release-pipeline-more-targets.yaml`.

The file can be found in these locations within the sample files:

* Bash: `/V2/bash/azuredevops/advanced`
* PowerShell: `/V2/powershell/azuredevops/advanced`

2. Ensure you don't have multiple YAML files that contain triggers (unless you designed your pipeline's workflow that way).
3. Fetch the aliases of the environments you want to target from the Cloud portal.
4. Insert the aliases into the following placeholders in `azure-release-pipeline-more-targets.yaml`:
  * `##Your target environment alias here##`
  * `##Your other target environment alias here##`

5. Fill in the `projectId` placeholder if you haven't already: `##Your project ID here##`.
6. Look at the triggers for the pipeline:

```yml
# Trigger when committing to main or flexible branch 
trigger:
  batch: true
  branches:
    include:
      - main
      - flexible
```

Here, you can change when a deployment is triggered based on which branch is pushed to.

The pipeline needs to resolve the target based on the triggering branch, which is done in the following code:

```yml
stages:
  # resolve which environment to deploy to based on the triggering branch
  - stage: resolveTarget
    displayName: Resolve Target Environment
    jobs:
      - job: setTargetEnvironment
        steps:
          - script: |
              echo "Triggering branch: $(Build.SourceBranchName)"
              if [ "$(Build.SourceBranchName)" = "main" ]; then
                echo "Target is: $(targetEnvironmentAlias)"
                echo "##vso[task.setvariable variable=targetEnvironment;isOutput=true]$(targetEnvironmentAlias)"
              elif [ "$(Build.SourceBranchName)" = "flexible" ]; then
                echo "Target is: $(flexibleTargetEnvironmentAlias)"
                echo "##vso[task.setvariable variable=targetEnvironment;isOutput=true]$(flexibleTargetEnvironmentAlias)"
              else
                echo "no target environment defined for branch: $(Build.SourceBranchName)"
                exit 1
              fi
            name: setTargetEnvironmentValue
```

The triggering branch is evaluated in the `if [ "$(Build.SourceBranchName)" = "main" ]; then` or `elif [ "$(Build.SourceBranchName)" = "flexible" ]; then` statement.

The code will write which alias is targeted and write a pipeline variable (`targetEnvironment`). This variable is used by steps later.

When updating the triggering branch names, it must be updated in the two mentioned places: 

* The trigger
* The script

{% endtab %}

{% tab title="GitHub Actions" %}

1. Replace the `main.yml` with the one called `main-more-targets.yml`. It's okay to rename `main-more-targets.yml`.

The file can be found in these locations within the sample files:

* Bash: `/V2/bash/github/advanced`
* PowerShell: `/V2/powershell/github/advanced`

2. Ensure you don't have multiple YAML files that contain triggers (unless you designed your pipeline's workflow that way).
3. Fetch the aliases of the environments you want to target from the Cloud portal.
4. Go to the repository in GitHub, and navigate to the Settings section.
5. Expand Secrets and Variables in the left-hand menu titled `Security` and click on `Actions`.
6. Go to the **Variables** tab.
7. Add a `repository variable` called `FLEXIBLE_ENVIRONMENT_ALIAS` and enter the environment alias you selected earlier.

If you followed the [GitHub guide](github-actions.md), you should already have a variable called `TARGET_ENVIRONMENT_ALIAS`.

Next, look at the triggers for the pipeline:

```yml
# Trigger when committing to the main branch
on:
  push:
    branches:
      - main
      - flexible
  workflow_dispatch: # Allow manual triggering of the workflow
```

Here, you can change when a deployment is triggered based on which branch is pushed to.

The pipeline needs to resolve the target based on the triggering branch. This is done with the following code:

```yml
jobs:
  # resolve which environment to deploy to based on the triggering branch
  set-env:
    runs-on: ubuntu-latest
    outputs:
      targetEnvironmentAlias: ${{ steps.set.outputs.targetEnvironmentAlias }}
    steps:
      - name: Resolve Target Environment
        id: set
        run: |
          echo "Triggering branch: ${{ github.ref_name }}"
          if [[ "${{ github.ref_name }}" == "main" ]]; then
            echo "Target is: $leftmostMainline"
            echo "targetEnvironmentAlias=$leftmostMainline" >> $GITHUB_OUTPUT
          elif [ "${{ github.ref_name }}" = "flexible" ]; then
            echo "Target is: $flexible"
            echo "targetEnvironmentAlias=$flexible" >> $GITHUB_OUTPUT
          else
            echo "no target environment defined for branch: $(Build.SourceBranchName)"
            exit 1
          fi
        env:
          leftmostMainline: ${{ vars.TARGET_ENVIRONMENT_ALIAS}}
          flexible: ${{ vars.FLEXIBLE_ENVIRONMENT_ALIAS }}
```

The triggering branch is evaluated in the statement `if [[ "${{ github.ref_name }}" == "main" ]]; then` or `elif [ "${{ github.ref_name }}" = "flexible" ]; then`.

The code will write which alias is targeted and write a pipeline variable (`targetEnvironmentAlias`). This variable is used by jobs later.

When updating the triggering branch names, it must be updated in the two mentioned places: 

* The trigger
* The script

{% endtab %}
{% endtabs %}
