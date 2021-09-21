# abapOpenChecks for Steampunk

Since the API used by the abapOpenChecks to implement ABAP Test Cockpit (ATC) checks is not released for use in an ABAP cloud environment, usage of the exising abapOpenChecks is not possible in such an environment.

This repository contains re-implementations of abapOpenChecks using an API released for use in Steampunk (currently still gated behind a feature toggle that can be activated on demand by SAP). Since this implementation of the checks does not need to be backwards compatible, we can take full advantage of modern ABAP features and new ATC feature like automated quick fixes.

## Installation

 1. Use the [abapGit](https://abapgit.org/) Eclipse plugin to pull this repository into your ABAP cloud environment.
 2. Create a new "ATC category" object with your ABAP Development Tools (ADT) with the description "abapOpenChecks" (or whatever you like)
 3. Create a new "ATC check" object with ADT for each check class (name pattern ZCL_AOE_CHECK_CLOUD_<index>) in this repository
 4. Create a new "ATC check variant" object with ADT - if you have executed the previous steps correctly, you should see a folder with the description from step 2 in the tree in the editor, containing one entry for each check created in step 3. Include whichever abapOpenChecks you want to execute in this variant.
  
The manual steps are unfortunately necessary because the new object types for categories/checks/check variants are not yet supported by abapGit.
  
## List of currently re-implemented checks
  
| AOC check index | with quick fix    |
| --------------- | --------------    |
| 1               | No (but possible) |
| 94              | Yes               |
