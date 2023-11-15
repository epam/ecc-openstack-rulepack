resource "openstack_images_image_v2" "rancheros" {
  name             = "032-image-red"
  image_source_url = "https://launchpad.net/cirros/trunk/0.3.2/+download/cirros-0.3.2-source.tar.gz"
  container_format = "bare"
  disk_format      = "qcow2"
}