provider "grafana" {
  url  = "http://0.0.0.0:3000"
  auth = "eyJrIjoiaTMzZ1dIR3ViR28xWTFHM2lXNm9IZ0xnMFBGbkRoclUiLCJuIjoiYWRtaW4iLCJpZCI6MX0="
}
provider "influxdb" {
  url      = "http://0.0.0.0:8086/"
  username = "admin"
}
resource "influxdb_database" "metrics" {
  name = "test"
}

resource "influxdb_user" "admin" {
  name     = "admin"
  password = "admin"
}

resource "grafana_data_source" "test" {
  type          = "influxdb"
  name          = "test"
  url           = "http://0.0.0.0:8086"
  username      = "admin"
  password      = "admin"
  database_name = "test"
}

resource "grafana_dashboard" "AppsPortal" {
  config_json = "${file("AppsPortalStatus-1558007884571.json")}"
  depends_on  = ["grafana_data_source.test"]
}
resource "grafana_dashboard" "IPProvisiong" {
  config_json = "${file("IPProvisiongStatus-1558007989766.json")}"
  depends_on  = ["grafana_data_source.test"]
}
