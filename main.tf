terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
    backend "s3" {
    bucket = "amdjab-img-store-bucket-state"
    key    = "newfolder/"
    region = "eu-central-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

# resource "aws_vpc" "dev-vpc" {
#     cidr_block = "10.0.0.0/24"
#     enable_dns_hostnames = true
#     tags = {
#         Name = "Dev-VPC"
#     }
# }


resource "aws_db_instance" "rds_instance" {
allocated_storage = 20
identifier =  "myrdsimagestore" 
storage_type = "gp2"
engine = "mysql"
engine_version = "8.0.27"
instance_class = "db.t2.micro"
db_name = "imagestoresql"
username = "root"
password = "awesomepa$$word"
publicly_accessible    = true
skip_final_snapshot    = true


  tags = {
    Name = "my-sql-rds-instance"
  }
}

resource "aws_s3_bucket" "b" {
  bucket = "amdjab-img-store-bucket"

  tags = {
    Name        = "amdjab-img-store-bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "state" {
  bucket = "amdjab-img-store-bucket-state"

  tags = {
    Name        = "amdjab-img-store-bucket-state"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}

resource "aws_iam_policy" "bucket-policy" {
  name        = "bucket-policy"
  path        = "/"
  description = "Image store bucket policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutAnalyticsConfiguration",
                "s3:PutAccessPointConfigurationForObjectLambda",
                "s3:GetObjectVersionTagging",
                "s3:DeleteAccessPoint",
                "s3:CreateBucket",
                "s3:DeleteAccessPointForObjectLambda",
                "s3:GetStorageLensConfigurationTagging",
                "s3:ReplicateObject",
                "s3:GetObjectAcl",
                "s3:GetBucketObjectLockConfiguration",
                "s3:DeleteBucketWebsite",
                "s3:GetIntelligentTieringConfiguration",
                "s3:PutLifecycleConfiguration",
                "s3:GetObjectVersionAcl",
                "s3:DeleteObject",
                "s3:GetBucketPolicyStatus",
                "s3:GetObjectRetention",
                "s3:GetBucketWebsite",
                "s3:GetJobTagging",
                "s3:PutReplicationConfiguration",
                "s3:GetObjectAttributes",
                "s3:PutObjectLegalHold",
                "s3:InitiateReplication",
                "s3:GetObjectLegalHold",
                "s3:GetBucketNotification",
                "s3:PutBucketCORS",
                "s3:DescribeMultiRegionAccessPointOperation",
                "s3:GetReplicationConfiguration",
                "s3:ListMultipartUploadParts",
                "s3:PutObject",
                "s3:GetObject",
                "s3:PutBucketNotification",
                "s3:DescribeJob",
                "s3:PutBucketLogging",
                "s3:GetAnalyticsConfiguration",
                "s3:PutBucketObjectLockConfiguration",
                "s3:GetObjectVersionForReplication",
                "s3:GetAccessPointForObjectLambda",
                "s3:GetStorageLensDashboard",
                "s3:CreateAccessPoint",
                "s3:GetLifecycleConfiguration",
                "s3:GetInventoryConfiguration",
                "s3:GetBucketTagging",
                "s3:PutAccelerateConfiguration",
                "s3:GetAccessPointPolicyForObjectLambda",
                "s3:DeleteObjectVersion",
                "s3:GetBucketLogging",
                "s3:ListBucketVersions",
                "s3:RestoreObject",
                "s3:ListBucket",
                "s3:GetAccelerateConfiguration",
                "s3:GetObjectVersionAttributes",
                "s3:GetBucketPolicy",
                "s3:PutEncryptionConfiguration",
                "s3:GetEncryptionConfiguration",
                "s3:GetObjectVersionTorrent",
                "s3:AbortMultipartUpload",
                "s3:GetBucketRequestPayment",
                "s3:GetAccessPointPolicyStatus",
                "s3:UpdateJobPriority",
                "s3:GetObjectTagging",
                "s3:GetMetricsConfiguration",
                "s3:GetBucketOwnershipControls",
                "s3:DeleteBucket",
                "s3:PutBucketVersioning",
                "s3:GetBucketPublicAccessBlock",
                "s3:ListBucketMultipartUploads",
                "s3:PutIntelligentTieringConfiguration",
                "s3:GetAccessPointPolicyStatusForObjectLambda",
                "s3:PutMetricsConfiguration",
                "s3:PutBucketOwnershipControls",
                "s3:UpdateJobStatus",
                "s3:GetBucketVersioning",
                "s3:GetBucketAcl",
                "s3:GetAccessPointConfigurationForObjectLambda",
                "s3:PutInventoryConfiguration",
                "s3:GetObjectTorrent",
                "s3:GetStorageLensConfiguration",
                "s3:DeleteStorageLensConfiguration",
                "s3:PutBucketWebsite",
                "s3:PutBucketRequestPayment",
                "s3:PutObjectRetention",
                "s3:CreateAccessPointForObjectLambda",
                "s3:GetBucketCORS",
                "s3:GetBucketLocation",
                "s3:GetAccessPointPolicy",
                "s3:ReplicateDelete",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:*:218159096403:accesspoint/*",
                "arn:aws:s3:::*/*",
                "arn:aws:s3:*:218159096403:storage-lens/*",
                "arn:aws:s3:::amdjab-img-store-bucket",
                "arn:aws:s3-object-lambda:*:218159096403:accesspoint/*",
                "arn:aws:s3:us-west-2:218159096403:async-request/mrap/*/*",
                "arn:aws:s3:*:218159096403:job/*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:GetMultiRegionAccessPointPolicyStatus",
                "s3:GetMultiRegionAccessPointRoutes",
                "s3:SubmitMultiRegionAccessPointRoutes",
                "s3:GetMultiRegionAccessPointPolicy",
                "s3:GetMultiRegionAccessPoint",
                "s3:DeleteMultiRegionAccessPoint",
                "s3:CreateMultiRegionAccessPoint"
            ],
            "Resource": "arn:aws:s3::218159096403:accesspoint/*"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "s3:ListStorageLensConfigurations",
                "s3:ListAccessPointsForObjectLambda",
                "s3:GetAccessPoint",
                "s3:GetAccountPublicAccessBlock",
                "s3:ListAllMyBuckets",
                "s3:ListAccessPoints",
                "s3:ListJobs",
                "s3:PutStorageLensConfiguration",
                "s3:ListMultiRegionAccessPoints",
                "s3:CreateJob"
            ],
            "Resource": "*"
        }
    ]
})
}


resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = "cli"
  policy_arn = aws_iam_policy.bucket-policy.arn
}



resource "aws_iam_policy" "rds-policy" {
  name        = "rds-policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "rds:DescribeDBProxyTargetGroups",
                "rds:DeleteBlueGreenDeployment",
                "rds:StartDBCluster",
                "rds:DeleteGlobalCluster",
                "rds:RestoreDBInstanceFromS3",
                "rds:ResetDBParameterGroup",
                "rds:DescribeGlobalClusters",
                "rds:ModifyDBProxyEndpoint",
                "rds:PurchaseReservedDBInstancesOffering",
                "rds:CreateDBSubnetGroup",
                "rds:ModifyCustomDBEngineVersion",
                "rds:DescribeDBProxyTargets",
                "rds:ModifyDBParameterGroup",
                "rds:DownloadDBLogFilePortion",
                "rds:AddRoleToDBCluster",
                "rds:DeleteDBInstance",
                "rds:DeleteDBProxy",
                "rds:DescribeReservedDBInstances",
                "rds:DescribeBlueGreenDeployments",
                "rds:CreateDBSnapshot",
                "rds:DeleteDBSecurityGroup",
                "rds:CreateEventSubscription",
                "rds:DescribeDBClusterBacktracks",
                "rds:DeleteOptionGroup",
                "rds:FailoverDBCluster",
                "rds:AddRoleToDBInstance",
                "rds:ModifyDBProxy",
                "rds:CreateDBInstance",
                "rds:DescribeDBInstances",
                "rds:DescribeDBProxies",
                "rds:ModifyActivityStream",
                "rds:DeleteDBCluster",
                "rds:DescribeDBProxyEndpoints",
                "rds:StartDBInstanceAutomatedBackupsReplication",
                "rds:ModifyEventSubscription",
                "rds:DescribeDBSnapshotAttributes",
                "rds:ModifyDBProxyTargetGroup",
                "rds:RebootDBCluster",
                "rds:ModifyDBSnapshot",
                "rds:DeleteDBClusterSnapshot",
                "rds:ListTagsForResource",
                "rds:CreateDBCluster",
                "rds:DeleteDBClusterParameterGroup",
                "rds:ApplyPendingMaintenanceAction",
                "rds:BacktrackDBCluster",
                "rds:RemoveRoleFromDBInstance",
                "rds:ModifyDBSubnetGroup",
                "rds:FailoverGlobalCluster",
                "rds:DescribeDBInstanceAutomatedBackups",
                "rds:RemoveRoleFromDBCluster",
                "rds:CreateGlobalCluster",
                "rds:DeregisterDBProxyTargets",
                "rds:CreateOptionGroup",
                "rds:CreateDBProxyEndpoint",
                "rds:AddSourceIdentifierToSubscription",
                "rds:CopyDBParameterGroup",
                "rds:ModifyDBClusterParameterGroup",
                "rds:ModifyDBInstance",
                "rds:RegisterDBProxyTargets",
                "rds:ModifyDBClusterSnapshotAttribute",
                "rds:CopyDBClusterParameterGroup",
                "rds:CreateDBClusterEndpoint",
                "rds:StopDBCluster",
                "rds:CreateDBParameterGroup",
                "rds:DescribeDBSnapshots",
                "rds:CreateBlueGreenDeployment",
                "rds:DeleteDBSnapshot",
                "rds:DescribeDBSecurityGroups",
                "rds:RemoveFromGlobalCluster",
                "rds:DeleteCustomDBEngineVersion",
                "rds:PromoteReadReplica",
                "rds:StartDBInstance",
                "rds:StopActivityStream",
                "rds:RestoreDBClusterFromS3",
                "rds:DeleteDBSubnetGroup",
                "rds:DescribeValidDBInstanceModifications",
                "rds:RestoreDBInstanceFromDBSnapshot",
                "rds:ModifyDBClusterEndpoint",
                "rds:ModifyDBCluster",
                "rds:DeleteDBParameterGroup",
                "rds:CreateDBClusterSnapshot",
                "rds:CreateDBClusterParameterGroup",
                "rds:ModifyDBSnapshotAttribute",
                "rds:PromoteReadReplicaDBCluster",
                "rds:DescribeOptionGroups",
                "rds:ModifyOptionGroup",
                "rds:RestoreDBClusterFromSnapshot",
                "rds:DescribeDBSubnetGroups",
                "rds:StartActivityStream",
                "rds:DescribePendingMaintenanceActions",
                "rds:DescribeDBParameterGroups",
                "rds:StopDBInstanceAutomatedBackupsReplication",
                "rds:DeleteEventSubscription",
                "rds:RemoveSourceIdentifierFromSubscription",
                "rds:DeleteDBProxyEndpoint",
                "rds:DeleteDBClusterEndpoint",
                "rds:RevokeDBSecurityGroupIngress",
                "rds:DescribeDBParameters",
                "rds:ModifyCurrentDBClusterCapacity",
                "rds:ResetDBClusterParameterGroup",
                "rds:RestoreDBClusterToPointInTime",
                "rds:CreateCustomDBEngineVersion",
                "rds:DescribeDBClusterSnapshotAttributes",
                "rds:DescribeDBClusterParameters",
                "rds:DescribeEventSubscriptions",
                "rds:CopyDBSnapshot",
                "rds:CopyDBClusterSnapshot",
                "rds:SwitchoverBlueGreenDeployment",
                "rds:DescribeDBLogFiles",
                "rds:StopDBInstance",
                "rds:CopyOptionGroup",
                "rds:SwitchoverReadReplica",
                "rds:CreateDBSecurityGroup",
                "rds:RebootDBInstance",
                "rds:ModifyGlobalCluster",
                "rds:DescribeDBClusterSnapshots",
                "rds:DescribeOptionGroupOptions",
                "rds:DownloadCompleteDBLogFile",
                "rds:DescribeDBClusterEndpoints",
                "rds:CreateDBInstanceReadReplica",
                "rds:DescribeDBClusters",
                "rds:DescribeDBClusterParameterGroups",
                "rds:RestoreDBInstanceToPointInTime"
            ],
            "Resource": [
                "arn:aws:rds:*:218159096403:cluster-snapshot:*",
                "arn:aws:rds:*:218159096403:target-group:*",
                "arn:aws:rds:*:218159096403:subgrp:*",
                "arn:aws:rds:*:218159096403:snapshot:*",
                "arn:aws:rds:*:218159096403:deployment:*",
                "arn:aws:rds::218159096403:global-cluster:*",
                "arn:aws:rds:*:218159096403:db-proxy-endpoint:*",
                "arn:aws:rds:*:218159096403:cluster:*",
                "arn:aws:rds:*:218159096403:secgrp:*",
                "arn:aws:rds:*:218159096403:cluster-endpoint:*",
                "arn:aws:rds:*:218159096403:cev:*/*/*",
                "arn:aws:rds:*:218159096403:cluster-pg:*",
                "arn:aws:rds:*:218159096403:db-proxy:*",
                "arn:aws:rds:*:218159096403:ri:*",
                "arn:aws:rds:*:218159096403:pg:*",
                "arn:aws:rds:*:218159096403:og:*",
                "arn:aws:rds:*:218159096403:es:*",
                "arn:aws:rds:*:218159096403:db:*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "rds:ModifyRecommendation",
                "rds:CancelExportTask",
                "rds:DescribeDBEngineVersions",
                "rds:CrossRegionCommunication",
                "rds:DescribeExportTasks",
                "rds:StartExportTask",
                "rds:DescribeEngineDefaultParameters",
                "rds:DeleteDBInstanceAutomatedBackup",
                "rds:DescribeRecommendations",
                "rds:DescribeReservedDBInstancesOfferings",
                "rds:ModifyCertificates",
                "rds:DescribeRecommendationGroups",
                "rds:DescribeOrderableDBInstanceOptions",
                "rds:DescribeEngineDefaultClusterParameters",
                "rds:DescribeSourceRegions",
                "rds:CreateDBProxy",
                "rds:DescribeCertificates",
                "rds:DescribeEventCategories",
                "rds:DescribeAccountAttributes",
                "rds:DescribeEvents"
            ],
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_user_policy_attachment" "test-attach1" {
  user       = "cli"
  policy_arn = aws_iam_policy.rds-policy.arn
}


# resource "aws_security_group" "sg1" {
#     name = "sg1"
#     vpc_id =  aws_vpc.dev-vpc.id

#     ingress {
#         from_port = 80
#         to_port = 80
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = ["0.0.0.0/0"]

#     }

# }


# resource "aws_security_group" "rdssg" {
#     name = "rdssg"
#     vpc_id =  aws_vpc.dev-vpc.id

#     ingress {
#         from_port = 3306
#         to_port = 3306
#         protocol = "tcp"
#         security_groups = [aws_security_group.sg1.id]

#     }

#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = ["0.0.0.0/0"]

#     }
# }