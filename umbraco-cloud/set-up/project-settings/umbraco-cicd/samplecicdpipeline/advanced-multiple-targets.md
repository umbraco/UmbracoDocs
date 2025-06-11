# Deploy to multiple targets
In this example we will show how to target deployments to more than one environment.

The sample will make it possible for you to work on two different branches where each branch will deploy to a different environment.

{% hint style="info" %}
With the CI/CD flow you can trigger deployments to multiple environments at the same time. 

If there is already a deployment in progress to a named environment, it will not be possible to trigger another until the first is done.
{% endhint %}

{% tabs %}
{% tab title="Azure DevOps" %}

Replace the `azure-release-pipeline.yaml` with the one called `azure-release-pipeline-more-targets.yaml`. It's okay to rename `azure-release-pipeline-more-targets.yaml`.
It's locations in the samples scripts are:
- For bash: `/V2/bash/azuredevops/advanded`
- For PowerShell: `/V2/powershell/azuredevops/advanded`

 Make sure you don't have multiple yaml files which contains triggers (unless you designed your pipelines workflow that way).

 Now you need the aliases of the environments you want to target.

 Insert the aliases into the placeholders in `azure-release-pipeline-more-targets.yaml`, the values you need to replace are:
- `##Your target environment alias here##`
- `##Your other target environment alias here##`
- Also remember to fix the projectId placeholder if you haven't already: `##Your project Id here##`

Next look at the triggers for the pipeline:

```yml
# Trigger when committing to main or flexible branch 
trigger:
  batch: true
  branches:
    include:
      - main
      - flexible
```

Here you can change when a deployment is trigger based on which branch is pushed to.

The pipeline needs to resolve the target based on the triggering branch, which is done in the following code.
```yml
stages:
  # resolve which environment to deploy to based on triggering branch
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

The triggering branch is evaluated in the statement `if [ "$(Build.SourceBranchName)" = "main" ]; then` or `elif [ "$(Build.SourceBranchName)" = "flexible" ]; then`.
The code will write which alias is targeted and write a pipeline variable (`targetEnvironment`). This variable is then used by later steps.

Note: When updating the triggering branch names it must be updated in the two mentioned places: In the trigger and in the script.


{% endtab %}
{% tab title="GitHub Actions" %}

Replace the `main.yml` with the one called `main-more-targets.yml`. It's okay to rename `main-more-targets.yml`.
It's locations in the samples scripts are:
- For bash: `/V2/bash/github/advanced`
- For PowerShell: `/V2/powershell/github/advanced`

 Make sure you don't have multiple yaml files which contains triggers (unless you designed your pipelines workflow that way).

 Now you need the aliases of the environments you want to target.
* Now go to the repository in GitHub, and click on the Settings section.
* Expand secrets and variables in the left-hand menu titled `Security` and click on `Actions`.
* Now go to the **Variables** tab
* Add a `repository variable` called `FLEXIBLE_ENVIRONMENT_ALIAS` and enter the environment alias you selected earlier.

If you followed the [GitHub guide](github-actions.md) you should already have a variable called `TARGET_ENVIRONMENT_ALIAS`.

Next look at the triggers for the pipeline:

```yml
# Trigger when committing to main branch
on:
  push:
    branches:
      - main
      - flexible
  workflow_dispatch: # Allow manual triggering of the workflow
```

Here you can change when a deployment is trigger based on which branch is pushed to.

The pipeline needs to resolve the target based on the triggering branch, which is done in the following code.
```yml
jobs:
  # resolve which environment to deploy to based on triggering branch
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
The code will write which alias is targeted and write a pipeline variable (`targetEnvironmentAlias`). This variable is then used by later jobs.

Note: When updating the triggering branch names it must be updated in the two mentioned places: In the trigger and in the script.

{% endtab %}
{% endtabs %}