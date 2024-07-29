PUT /bench
{
  "mappings": {
    "properties": {
      "benchmark":                      { "type": "text"    },
      "mode":                           { "type": "keyword" },
      "warmupIterations":               { "type": "integer" },
      "warmupTime":                     { "type": "keyword" },
      "warmupBatchSize":                { "type": "integer" },
      "measurementIterations":          { "type": "integer" },
      "measurementTime":                { "type": "keyword" },
      "measurementBatchSize":           { "type": "integer" },
      "score":                          { "type": "double"  },
      "scoreError":                     { "type": "double"  },
      "scoreConfidence":                { "type": "double"  },
      "scoreUnit":                      { "type": "keyword" },
      "benchmarkClass":                 { "type": "keyword" },
      "benchmarkType":                  { "type": "keyword" },
      "benchmarkMethod":                { "type": "keyword" },
      "0.0":                            { "type": "double"  },
      "50.0":                           { "type": "double"  },
      "90.0":                           { "type": "double"  },
      "95.0":                           { "type": "double"  },
      "99.0":                           { "type": "double"  },
      "99.9":                           { "type": "double"  },
      "99.99":                          { "type": "double"  },
      "99.999":                         { "type": "double"  },
      "99.9999":                        { "type": "double"  },
      "100.0":                          { "type": "double"  },
      "fakeTimestamp":                  { "type": "long"    },
      "size":                           { "type": "keyword" }
    }
  }
}
