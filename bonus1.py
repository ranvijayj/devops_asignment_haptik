import boto3
import datetime

class dimension(dict):
	def __init__(self, name, value):
        self[name] = value



def get_elb_stats(name, metric, minutes=60, period=60):

try:
	cl = boto3.connect_cloudwatch()
	E = datetime.datetime.utcnow()
	S = E - datetime.timedelta(minutes=minutes)
	stats = c.get_metric_statistics(period, S, E, M,'AWS/ELB', 'Sum',InstanceDimension("LoadBalancerName", name))
	for stat in stats:
		final.append(str(stat[u'Timestamp'])+"|"+str(stat[u'Sum'])))
except:
	print "ERROR"
def get_elb():
	elb_conn = boto.ec2.elb.connect_to_region(aws_access_key_id=app.config['AWS_ACCESS_KEY_ID'], aws_secret_access_key=app.config['AWS_SECRET_KEY'], region_name=region)
	return elb_conn.get_all_load_balancers([app.config['ELB_NAME']])[0]
def add_instance_in_elb(instances):
                elb = get_elb()
                for i in L:
                        elb.register_instances(i)
                        print "Added "+str(i)+" behind elb"
def resize_inst(instance)
	client = boto3.client('ec2')
	client.stop_instances(InstanceIds=[instance])
	waiter=client.get_waiter('instance_stopped')
	waiter.wait(InstanceIds=[instance])
	client.modify_instance_attribute(InstanceId=instance, Attribute='instanceType', Value='m4.xlarge')

if __name__ == "__main__":
final=[]
name="ELB NAME"
M="RequestCount"
req=1000
list_inst_to_add=['id1','id2']
mongoinst="mongo instance id"
#SCALING
get_elb_stats(name,M,1,60)
for _ in final:
	if int(_.split("|")) > req:
		add_instance_in_elb(list_inst_to_add)
#RESIZE INSTANCE
resize_inst(mongoinst)
