## 1.2.0 (November 22nd, 2022)

IMPROVEMENTS

* This module can now be run with version 4 of the AWS provider.

BACKWARDS INCOMPATIBILITIES / NOTES:

* This module now requires Terraform 1.0 or higher.


## 1.1.0 (May 28th, 2021)

IMPROVEMENTS

* The certificate to use on the created domain name can now be specified via the
  `certificate_arn` variable.

## 1.0.0 (May 27th, 2021)

BACKWARDS INCOMPATIBILITIES / NOTES:

* This module is now compatible with Terraform 0.14 and higher.

## 0.1.4 (September 9th, 2017) 

IMPROVEMENTS:

* The zone ID and the DNS name of the ELB are now output from the module.   