PUT /uiscv
{
  "mappings": {
    "properties": {
      "timestamp":           { "type": "date", "format" : "iso8601" },
      "suiteName":           { "type": "text" },
      "suiteDescription":    { "type": "text" },
      "testName":            { "type": "text" },
      "testDescription":     { "type": "text" },
      "templateName":        { "type": "text" },
      "templateDescription": { "type": "text" },
      "duration":            { "type": "integer" },
      "result":              { "type": "keyword" },
      "severity":            { "type": "keyword" },
      "testGroup":           { "type": "keyword" },
      "testSubgroup":        { "type": "keyword" },
      "testType":            { "type": "keyword" },
      "errorMessage":        { "type": "text" }
    }
  }
}
