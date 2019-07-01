
Prepare audio stats for bulk insert.

```
ruby ./stats-bulk.rb <audio-stats-log>
```

```
curl -s -H "Content-Type: application/x-ndjson" -XPOST localhost:9200/_bulk --data-binary "@bulk.json"; echo
```

```
GET test_audio_stats/_search
{
  "query": {
    "match" : {
      "uuid.keyword": "83dbddda-ab11-4b09-bf26-e0919131a48b"
    }
  }
}
```

Return only certain fields.

```
GET test_audio_stats/_search
{
  "_source": [
    "uuid",
    "stats.audio.in_mos",
    "timestamp",
    "user_id",
    "user_name",
    "voice_bridge"
  ],
  "query": {
    "match" : {
      "uuid.keyword": "7dd6b1ce-bbf1-470c-88b6-43977de647e4"
    }
  }
}
```

```
GET test_audio_stats/_search
{
  "size": 0,
  "aggs": {
    "uuid_buckets": {
      "composite": {
        "sources" : [
          { "uuid": {"terms": { "field" : "uuid.keyword"}}}
        ],
        "size":200
      },
      "aggs":{
          "avg_mos_score": {
            "stats": {
              "field":"stats.audio.in_mos"
            }
          }
        }
      }
    }
  }
```

```
GET test_audio_stats/_search
{
  "size": 0,
  "aggs": {
    "uuid_buckets": {
      "composite": {
        "sources" : [
          { "uuid": {"terms": { "field" : "uuid.keyword"}}}
        ],
        "after" : {
          "uuid" : "07b85770-cec3-4d33-b77d-54c853d8b60a"
        },
        "size":200
      },
            "aggs":{
          "avg_mos_score": {
            "stats": {
              "field":"stats.audio.in_mos"
            }
          }
        }
      
    }
  }
}
```