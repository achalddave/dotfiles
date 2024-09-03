import boto3

# Create a SageMaker client
sagemaker = boto3.client("sagemaker")

# List the training jobs
response = sagemaker.list_training_jobs(MaxResults=100, StatusEquals="InProgress")

jobs = []
# For each training job, get the number of instances
for job in response["TrainingJobSummaries"]:
    job_name = job["TrainingJobName"]
    job_description = sagemaker.describe_training_job(TrainingJobName=job_name)
    instance_count = job_description["ResourceConfig"]["InstanceCount"]
    jobs.append((job_name, instance_count))

for job_name, instance_count in sorted(jobs, key=lambda x: x[1], reverse=True):
    print(f"{job_name} ({instance_count})")
