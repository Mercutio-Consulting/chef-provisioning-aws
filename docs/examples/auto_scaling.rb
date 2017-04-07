require 'chef/provisioning/aws_driver'

with_driver 'aws::eu-west-2b' do
  aws_launch_config 'testnode' do
    image 'ami-a58d0dc5'
    instance_type 't1.micro'
  end

  aws_auto_scaling_group 'nodescaling' do
    desired_capacity 3
    min_size 1
    max_size 5
    launch_configuration 'my-sweet-launch-config'
    notification_configurations(
      topic: 'arn::aws::sns::eu-west2b:<account_id>:<my-topic>',
      types: [
        'autoscaling:EC2_INSTANCE_LAUNCH',
        'autoscaling:EC2_INSTANCE_TERMINATE'
      ]
    )
    scaling_policies(
      'my-amazing-scaling-policy' => {
        adjustment_type: 'ChangeInCapacity',
        scaling_adjustment: 1
      }
    )
  end
end
