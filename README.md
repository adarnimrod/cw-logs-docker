# AWS ClougWatch Agent

Send files to CloudWatch logs.

## Usage

Run with the directory of the log file mounted inside the container and
specifying the `LOG_GROUP_NAME`, `LOG_STREAM_NAME` and `LOG_FILE` environment
variables. Also, the usual [AWS CLI environment
variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)
can also be specified. Lastly, the AWS region is deduced on startup by accessing
the [instance
metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html#instancedata-data-retrieval),
unless the `AWS_DEFAULT_REGION` enviroment variable is specified. By default the
container uses the `nobody` user, but you may need to specify a different user
in case the log file is not readable but that user. For [file rotation
detection](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AgentReference.html#agent-faq),
don't mount just the file but the whole directory inside the container.

## Example usage

```
docker run -d -v '/var/log:/var/log:ro' -e 'LOG_GROUP_NAME=/var/log/' -e 'LOG_STREAM_NAME={instance_id}' -e 'LOG_FILE=/var/log/ecs/ecs-agent.log.*' adarnimrod/cw-logs
```

## License

This software is licensed under the MIT license (see `LICENSE.txt`).

## Author Information

Nimrod Adar, [contact me](mailto:nimrod@shore.co.il) or visit my [website](
https://www.shore.co.il/). Patches are welcome via [`git send-email`](
http://git-scm.com/book/en/v2/Git-Commands-Email). The repository is located
at: <https://www.shore.co.il/git/>.
