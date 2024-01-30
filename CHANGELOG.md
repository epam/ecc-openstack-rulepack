
### :open_file_folder: Initial version

## [v1.0] - 2024-01-30
### :sparkles: New Policies
- [`0f9ec62`](https://github.com/epam/ecc-openstack-rulepack/commit/0f9ec623127d7f9b9ff0d8a1377d6782571c7f21) - added policy ecc-openstack-001-instance_has_default_sg_attached
- [`fc400d0`](https://github.com/epam/ecc-openstack-rulepack/commit/fc400d09667bce7e92bbcc1707881489c037d5c4) - added policy ecc-openstack-002-volume_not_in_use
- [`b81bd53`](https://github.com/epam/ecc-openstack-rulepack/commit/b81bd5337a05a57e67e84f8507fdcb1705735a14) - added policy ecc-openstack-003-user_has_admin_privileges_on_domain_and_system_level
- [`a9db163`](https://github.com/epam/ecc-openstack-rulepack/commit/a9db163f2f91ce9a64691d80ad81f9e399812311) - added policy ecc-openstack-004-user_disabled
- [`206f67a`](https://github.com/epam/ecc-openstack-rulepack/commit/206f67a140ab8226ebf0f2af8e66f1f1171c48b6) - added policy ecc-openstack-005-volume_not_encrypted
- [`fd03c63`](https://github.com/epam/ecc-openstack-rulepack/commit/fd03c636d230bd10ba0b212055d67f25dd455dcd) - added policy ecc-openstack-006-instance_volume_delete_on_termination_enabled
- [`26c45ae`](https://github.com/epam/ecc-openstack-rulepack/commit/26c45aebc14ce7a2099c8edda37723b025539ffb) - added policy ecc-openstack-007-instance_is_public
- [`e09ba68`](https://github.com/epam/ecc-openstack-rulepack/commit/e09ba68b707121d786cb39f9cfc811d8b9216d5f) - added policy ecc-openstack-008-volume_in_state_error
- [`4cb405d`](https://github.com/epam/ecc-openstack-rulepack/commit/4cb405d287bbbacc2ae19bd780e6292f4cae64b6) - added policy ecc-openstack-009-project_without_tags
- [`e2f4405`](https://github.com/epam/ecc-openstack-rulepack/commit/e2f440524c30a13c346f3f94c7fd80d9073316b8) - added policy ecc-openstack-010-instance_without_tags
- [`510cbcd`](https://github.com/epam/ecc-openstack-rulepack/commit/510cbcd609d62ea35a05196e230b40e2fd108a1b) - added policy ecc-openstack-011-volume_without_metadata
- [`6de435c`](https://github.com/epam/ecc-openstack-rulepack/commit/6de435cf4da45dce8e55fd9ab1dee8c809c43cb7) - added policy ecc-openstack-012-prevent_unrestricted_ingress
- [`544c48c`](https://github.com/epam/ecc-openstack-rulepack/commit/544c48c0bd390f9e6f5b91f7701290cc3bfb7052) - added policy ecc-openstack-013-security_group_ingress_unrestricted_22
- [`0c8e58e`](https://github.com/epam/ecc-openstack-rulepack/commit/0c8e58e316d2e7cbd5b2d5917283f9018fc4961a) - added policy ecc-openstack-014-security_group_ingress_unrestricted_80_and_443
- [`d6f2526`](https://github.com/epam/ecc-openstack-rulepack/commit/d6f25260f717c520d46f4bf8222ee4c914ae030f) - added policy ecc-openstack-015-default_security_group_not_restricts_all_traffic
- [`d7cd2f1`](https://github.com/epam/ecc-openstack-rulepack/commit/d7cd2f13bf1877290f2cb6aaf309984a15fad504) - added policy ecc-openstack-016-security_group_ingress_unrestricted_3389
- [`99187ac`](https://github.com/epam/ecc-openstack-rulepack/commit/99187ac82f9973a62910022c086656de62dc00b6) - added policy ecc-openstack-017-security_group_ingress_unrestricted_27017
- [`d460d92`](https://github.com/epam/ecc-openstack-rulepack/commit/d460d92a6df4c9451876f0793725015cc591b93d) - added policy ecc-openstack-018-security_group_ingress_unrestricted_3306
- [`6d283e2`](https://github.com/epam/ecc-openstack-rulepack/commit/6d283e2e6517a91bca7396e8b67026c4bab70737) - added policy ecc-openstack-019-security_group_ingress_unrestricted_1521
- [`4db6c4f`](https://github.com/epam/ecc-openstack-rulepack/commit/4db6c4f9e7661668825b673eca6c31808e6b741b) - added policy ecc-openstack-020-security_group_ingress_unrestricted_1433_1434
- [`7f6e853`](https://github.com/epam/ecc-openstack-rulepack/commit/7f6e85366c90771f9d0500e8e3109ec04e57a79a) - added policy ecc-openstack-021-security_group_ingress_unrestricted_5432
- [`e2a39d6`](https://github.com/epam/ecc-openstack-rulepack/commit/e2a39d6da52f9abb5f5d568d2e6d4f0a7acc0eb4) - added policy ecc-openstack-022-security_group_ingress_unrestricted_23
- [`01b0c48`](https://github.com/epam/ecc-openstack-rulepack/commit/01b0c48ce68f31aa166d3e8b9d7fe4cba9bed556) - added policy ecc-openstack-023-unrestricted_outbound_traffic
- [`cf4bd2a`](https://github.com/epam/ecc-openstack-rulepack/commit/cf4bd2a7db22dc1759f0fca597e7405eb5c329ee) - added policy ecc-openstack-024-security_group_without_tag_information
- [`ba6983e`](https://github.com/epam/ecc-openstack-rulepack/commit/ba6983e855a29dfd73bd6d507285a7f28ddd238c) - added policy ecc-openstack-025-server_with_unrestricted_common_ports_part1
- [`fdbf45f`](https://github.com/epam/ecc-openstack-rulepack/commit/fdbf45f1c10f4f802c9aca3ed86d90f34bb83246) - added policy ecc-openstack-026-server_with_unrestricted_common_ports_part2
- [`57642ef`](https://github.com/epam/ecc-openstack-rulepack/commit/57642ef23b8d050df9ca456dbe41e4ca75419f8f) - added policy ecc-openstack-027-user_mfa_disabled
- [`feaf9ae`](https://github.com/epam/ecc-openstack-rulepack/commit/feaf9aece0a07a9e45caeb3751b99df7ac3c7f0d) - added policy ecc-openstack-028-ignore_lockout_failure_attempts_enabled
- [`64e1a6e`](https://github.com/epam/ecc-openstack-rulepack/commit/64e1a6e04dec0b887387bb39b3d55bae4daabdeb) - added policy ecc-openstack-029-ignore_password_expiry
- [`ad2d505`](https://github.com/epam/ecc-openstack-rulepack/commit/ad2d505be4919322eeaf8b1837767e60ebbc9ab6) - added policy ecc-openstack-030-user_without_password_expiration
- [`9986fa8`](https://github.com/epam/ecc-openstack-rulepack/commit/9986fa861c81c0e6c98aeda2557f9c3a13d35272) - added policy ecc-openstack-031-secret_without_expiration
- [`1883ffd`](https://github.com/epam/ecc-openstack-rulepack/commit/1883ffd4e5cbfaafcfcdfdccd51c946c42013311) - added policy ecc-openstack-032-image_not_signed


[v1.0]: https://github.com/epam/ecc-openstack-rulepack/compare/Init...v1.0