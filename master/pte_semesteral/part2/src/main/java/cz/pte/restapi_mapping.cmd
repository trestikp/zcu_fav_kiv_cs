PUT /restapi
{
  "mappings": {
    "properties": {
      "totalTime":          { "type": "integer"             },
      "testSuite":          { "type": "keyword"             },
      "ipAddress":          { "type": "text"                },
      "readTime":           { "type": "integer"             },
      "httpMethod":         { "type": "keyword"             },
      "timeToFirstByte":    { "type": "unsigned_long"       },
      "timeTaken":          { "type": "integer"             },
      "endpoint":           { "type": "text"                },
      "connectTime":        { "type": "long"                },
      "dnsTime":            { "type": "integer"             },
      "httpStatus":         { "type": "integer"             },
      "name":               { "type": "keyword"             },
      "contentLength":      { "type": "integer"             },
      "status":             { "type": "keyword"             },
      "timestamp":          { "type": "date", "format" : "iso8601"},
      "testCase":           { "type": "keyword"             },
      "messages":           { "type": "text"                }
    }
  }
}
