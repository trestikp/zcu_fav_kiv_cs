PUT /testviz
{
  "mappings": {
    "properties": {
       "timestamp": { "type": "date", "format" : "iso8601" },
       "url": { "type": "text" },
       "browser": { "type": "keyword" },
       "testName": { "type": "keyword" },
       "testResult": { "type": "boolean" },
       "durationMSec": { "type": "integer" },
       "durationPassed": { "type": "boolean" }
    }
  }
}