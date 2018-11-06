module "training-beta" {
  source = "modules/vgcn-node"
  count  = 1
  flavor = "c.c10m55"

  # custom image
  image       = "vggp-v31-j95-9c1a332fb4d7-master"
  name        = "training-beta"
  is_training = "True"
  galaxygroup = "training-beta"
}

module "training-bioinfbrad2018_1" {
  source      = "modules/vgcn-node"
  count       = 1
  flavor      = "c.c10m55"
  name        = "training-bioinfbrad2018_1"
  galaxygroup = "training-bioinfbrad2018_1"
  is_training = "True"
}

module "training-20181106ngs" {
  source      = "modules/vgcn-node"
  count       = 4
  flavor      = "c.c10m55"
  name        = "training-20181106ngs"
  galaxygroup = "training-20181106ngs"
  is_training = "True"
}

module "training-ucabgt2018" {
  source      = "modules/vgcn-node"
  count       = 4
  flavor      = "c.c10m55"
  name        = "training-ucabgt2018"
  galaxygroup = "training-ucabgt2018"
  is_training = "True"
}

module "training-big-data2018" {
  # 11/19/2018
  # 11/23/2018
  source      = "modules/vgcn-node"
  count       = 10
  flavor      = "c.c16m120"
  name        = "training-big-data2018"
  galaxygroup = "training-big-data2018"
  is_training = "True"
}

module "training-emc2018" {
  # 11/22/2018
  # 11/23/2018
  source      = "modules/vgcn-node"
  count       = 15
  flavor      = "c.c16m120"
  name        = "training-emc2018"
  galaxygroup = "training-emc2018"
  is_training = "True"
}
