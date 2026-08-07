{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Single-node cluster (roles = master + node on the same host): loopback
  # avoids hardcoding a dynamic LAN IP that breaks the easyCerts bootstrap.
  kubeMasterIP = "127.0.0.1";
  kubeMasterHostname = "api.kube";
  kubeMasterAPIServerPort = 6443;
in
{
  # resolve master hostname
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";

  # packages for administration tasks
  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
  ];

  services.kubernetes =
    let
      api = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
    in
    {
      roles = [
        "master"
        "node"
      ];
      masterAddress = kubeMasterHostname;
      easyCerts = true;

      # point kubelet and other services to kube-apiserver
      kubelet.kubeconfig.server = api;
      apiserverAddress = api;

      # use coredns
      addons.dns.enable = true;

      # needed if you use swap
      kubelet.extraOpts = "--fail-swap-on=false";
    };
}

# Link your kubeconfig to your home directory:

# ln -s /etc/kubernetes/cluster-admin.kubeconfig ~/.kube/config

# then try kubectl cluster-info
