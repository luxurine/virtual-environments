# Build Image on GCP

## Windows Server

**install packer gcp plugin**

```shell
packer init images.gcp/config.pkr.hcl
```

**build image**

```shell
gcloud auth application-default login
packer build images.gcp/win/windows2019.json
```
