# Valkyrie / Shrine Experiments
Experimental code to test and evaluate [Samvera Valkyrie](https://github.com/samvera/valkyrie).

This is based on  [Valkyrie-Shrine](https://github.com/samvera-labs/valkyrie-shrine) which allows the configuration of Valkyrie with [Shrine](http://shrinerb.com/) storage adapters. Shrine is useful here because valkyrie does not provide a 'native' S3 adapter.

The eventual goal is to test:

1. The S3 storage adapter with MinIO in a MS Azure environment
2. The file-system storage adapter with MS Azure object storage (via NFS)

This is being approached with gradual steps:

- [x] Test 'native' Valkyrie file-system adapter with local disk storage (status: **success**)
- [x] Test Shrine file-system (without Valkyrie) with local disk storage (status: **success**)
- [x] Test Valkyrie-Shrine file-system adapter with local disk storage (status: **success**)
- [x] Test Shrine S3 adapter (without Valkyrie) with Linode S3 interface (status: **success**)
- [x] Test Valkyrie-Shrine S3 adapter with Linode S3 interface (status: **success**)
- [ ] Test Valkyrie-Shrine file-system adapter with MS Azure Object store via NFS
- [ ] Test Valkyrie-Shrine S3 adapter with MinIO S3 interface running on MS Azure AKS service

