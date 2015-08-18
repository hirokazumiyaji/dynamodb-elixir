defmodule DynamoDB do

  defmodule AttributeDefinition do
    defstruct AttributeName: nil, AttributeType: nil
    @type t :: %AttributeDefinition{AttributeName: binary, AttributeType: binary}
  end

  defmodule AttributeValue do
    defstruct B: nil, BOOL: nil, BS: nil, L: nil, M: nil, N: nil, NS: nil, NULL: nil, S: nil, SS: nil
    @type t :: %AttributeValue{B: binary, BOOL: boolean, BS: list, L: list, M: binary, N: binary, NS: list, NULL: boolean, S: binary, SS: list}
  end

  defmodule AttributeValueUpdate do
    defstruct Action: nil, Value: nil
    @type t :: %AttributeValueUpdate{Action: binary, Value: AttributeValue}
  end

  defmodule Capacity do
    defstruct CapacityUnits: nil
    @type t :: %Capacity{CapacityUnits: float}
  end

  defmodule Condition do
    defstruct ComparisonOperator: nil, AttributeValueList: []
    @type t :: %Condition{ComparisonOperator: binary, AttributeValueList: list}
  end

  defmodule ConsumedCapacity do
    defstruct CapacityUnits: nil, GlobalSecondaryIndexes: nil, LocalSecondaryIndexes: nil, Table: nil, TableName: nil
    @type t :: %ConsumedCapacity{CapacityUnits: float, GlobalSecondaryIndexes: binary, LocalSecondaryIndexes: binary, Table: Capacity, TableName: binary}
  end

  defmodule CreateGlobalSecondaryIndexAction do
    defstruct IndexName: nil, KeySchema: [], Projection: nil, ProvisionedThroughput: nil
    @type t :: %CreateGlobalSecondaryIndexAction{IndexName: binary, KeySchema: list, Projection: Projection, ProvisionedThroughput: ProvisionedThroughput}
  end

  defmodule DeleteGlobalSecondaryIndexAction do
    defstruct IndexName: nil
    @type t :: %DeleteGlobalSecondaryIndexAction{IndexName: binary}
  end

  defmodule DeleteRequest do
    defstruct Key: nil
    @type t :: %DeleteRequest{Key: binary}
  end

  defmodule ExpectedAttributeValue do
    defstruct AttributeValueList: [], ComparisonOperator: nil, Exists: nil, Value: nil
    @type t :: %ExpectedAttributeValue{AttributeValueList: list, ComparisonOperator: binary, Exists: boolean, Value: AttributeValue}
  end

  defmodule GlobalSecondaryIndex do
    defstruct IndexName: nil, KeySchema: [], Projection: nil, ProvisionedThroughput: nil
    @type t :: %GlobalSecondaryIndex{IndexName: binary, KeySchema: list, Projection: Projection, ProvisionedThroughput: ProvisionedThroughput}
  end

  defmodule GlobalSecondaryIndexDescription do
    defstruct Backfilling: nil, IndexArn: nil, IndexName: nil, IndexSizeBytes: nil, IndexStatus: nil, ItemCount: nil, KeySchema: nil, Projection: nil, ProvisionedThroughput: nil
    @type t :: %GlobalSecondaryIndexDescription{Backfilling: boolean, IndexArn: binary, IndexName: binary, IndexSizeBytes: integer, IndexStatus: binary, ItemCount: integer, KeySchema: list, Projection: Projection, ProvisionedThroughput: ProvisionedThroughputDescription}
  end

  defmodule GlobalSecondaryIndexUpdate do
    defstruct Create: nil, Delete: nil, Update: nil
    @type t :: %GlobalSecondaryIndexUpdate{Create: CreateGlobalSecondaryIndexAction, Delete: DeleteGlobalSecondaryIndexAction, Update: UpdateGlobalSecondaryIndexAction}
  end

  defmodule ItemCollectionMetrics do
    defstruct ItemCollectionKey: nil, SizeEstimateRangeGB: nil
    @type t :: %ItemCollectionMetrics{ItemCollectionKey: binary, SizeEstimateRangeGB: list}
  end

  defmodule KeySchemaElement do
    defstruct AttributeName: nil, KeyType: nil
    @type t :: %KeySchemaElement{AttributeName: binary, KeyType: binary}
  end

  defmodule KeysAndAttributes do
    defstruct Keys: [], AttributesToGet: []
    @type t :: %KeysAndAttributes{Keys: list, AttributesToGet: list}
  end

  defmodule LocalSecondaryIndex do
    defstruct IndexName: nil, KeySchema: [], Projection: nil
    @type t :: %LocalSecondaryIndex{IndexName: binary, KeySchema: list, Projection: Projection}
  end

  defmodule LocalSecondaryIndexDescription do
    defstruct IndexArn: nil, IndexName: nil, IndexSizeBytes: nil, ItemCount: nil, KeySchema: [], Projection: nil
    @type t :: %LocalSecondaryIndexDescription{IndexArn: binary, IndexName: binary, IndexSizeBytes: integer, ItemCount: integer, KeySchema: list, Projection: Projection}
  end

  defmodule Projection do
    defstruct NonKeyAttributes: [], ProjectionType: nil
    @type t :: %Projection{NonKeyAttributes: list, ProjectionType: binary}
  end

  defmodule ProvisionedThroughput do
    defstruct ReadCapacityUnits: 1, WriteCapacityUnits: 1
    @type t :: %ProvisionedThroughput{ReadCapacityUnits: integer, WriteCapacityUnits: integer}
  end

  defmodule ProvisionedThroughputDescription do
    defstruct LastDecreaseDateTime: nil, LastIncreaseDateTime: nil, NumberOfDecreasesToday: nil, ReadCapacityUnits: nil, WriteCapacityUnits: nil
    @type t :: %ProvisionedThroughputDescription{LastDecreaseDateTime: binary, LastIncreaseDateTime: binary, NumberOfDecreasesToday: binary, ReadCapacityUnits: integer, WriteCapacityUnits: integer}
  end

  defmodule PutRequest do
    defstruct Item: nil
    @type t :: %PutRequest{Item: binary}
  end

  defmodule StreamSpecification do
    defstruct StreamEnabled: false, StreamViewType: nil
    @type t :: %StreamSpecification{StreamEnabled: boolean, StreamViewType: binary}
  end

  defmodule TableDescription do
    defstruct AttributeDefinitions: [], CreationDateTime: nil, GlobalSecondaryIndexes: [], ItemCount: nil, KeySchema: [], LatestStreamArn: nil, LatestStreamLabel: nil, LocalSecondaryIndexes: [], ProvisionedThroughput: nil, StreamSpecification: nil, TableArn: nil, TableName: nil, TableSizeBytes: nil, TableStatus: nil
    @type t :: %TableDescription{AttributeDefinitions: list, CreationDateTime: binary, GlobalSecondaryIndexes: list, ItemCount: integer, KeySchema: list, LatestStreamArn: binary, LatestStreamLabel: binary, LocalSecondaryIndexes: list, ProvisionedThroughput: ProvisionedThroughputDescription, StreamSpecification: StreamSpecification, TableArn: binary, TableName: binary, TableSizeBytes: integer, TableStatus: binary}
  end

  defmodule UpdateGlobalSecondaryIndexAction do
    defstruct IndexName: nil, ProvisionedThroughput: nil
    @type t :: %UpdateGlobalSecondaryIndexAction{IndexName: binary, ProvisionedThroughput: ProvisionedThroughput}
  end

  defmodule WriteRequest do
    defstruct DeleteRequest: nil, PutRequest: nil
    @type t :: %WriteRequest{DeleteRequest: DeleteRequest, PutRequest: PutRequest}
  end

  use DynamoDB.BatchGetItem
  use DynamoDB.BatchWriteItem
  use DynamoDB.CreateTable
  use DynamoDB.DeleteItem
  use DynamoDB.DeleteTable
  use DynamoDB.DescribeTable
  use DynamoDB.GetItem
  use DynamoDB.ListTables
  use DynamoDB.PutItem
  use DynamoDB.Query
  use DynamoDB.Scan
  use DynamoDB.UpdateItem
  use DynamoDB.UpdateTable
end
