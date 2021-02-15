#  Migration to v10

## Breaking changes

- `Route` now encodes to a single value again rather than an object.  If you have previously saved documents using v9 containing a `Route`, you'll need to re-encode them. For example, with a JSONEncoder
Prior to v9
```javascript
    "route": "10A"
```

v9
```javascript
    "route": {
        "id": "10A"
    }
```

v10
```javascript
    "route"": "10A"
```

-`Stop` now encodes to a single value. If you have previously saved documents containing a `Stop`, you'll need to re-encode them. For example with JSONEncoder
Prior to v10
```javascript
    "stop": {
        "id": "1234567"
    }
```

v10
```javascript
    "stop": "1234567"
```

- `StopInfo`'s `time` field now decodes to a `Date` rather than a `String`.
