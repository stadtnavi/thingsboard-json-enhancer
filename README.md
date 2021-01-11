# thingsboard-json-enhancer

Enhances given JSON template files with realtime-properties requested from thingsboard.

Templates are rendered using jinja2 and may access timeseries and attributes of thingsboard-ID identified devices.

```
{
  "type": "FeatureCollection",
  "features": [
    {% for id in ['9c3f8090-0563-11ea-9a2d-876c1a6b66b2', '76d596d0-fe0d-11e9-9a2d-876c1a6b66b2'] %}
    {
      "type": "Feature",
      "properties": {
        "address": "{{ fetch_attribute(id, 'address')}}",
        "airTemperatureC":  {{ fetch_attribute(id, 'temp')}},
        "roadTemperatureC": {{ fetch_timeseries(id, 'act_temp_road_surf') }},
        "precipitationType": {{ fetch_timeseries(id, 'prec_type') }},
        "roadCondition": {{ fetch_timeseries(id, 'act_road_condition') }},
        "updatedAt": "{{ fetch_minimum_timestamp(id) }}"
      },
      "geometry": {
        "type": "Point",
        "coordinates": [
          {{ fetch_attribute(id,'longitude') }},
          {{ fetch_attribute(id,'latitude') }}
        ]
      }
    }{{ ", " if not loop.last }} 
    {% endfor %}
  ]
}
```

Run it with e.g.:

```
THINGSBOARD_HOST='<host>' THINGSBOARD_USERNAME='<username>' THINGSBOARD_PASSWORD='<password>' ./thingsboard-json-enhancer -i templates/taxi/ -o out/taxi/
```

Using docker:

```sh
$ docker build -t stadtnavi/thingsboard-json-enhancer .
$ docker run --rm -v $(PWD)/out/taxi:/out --env THINGSBOARD_HOST='<host2>' --env THINGSBOARD_USERNAME='<username>' --env THINGSBOARD_PASSWORD='<password>' stadtnavi/thingsboard-json-enhancer thingsboard-json-enhancer -i templates/taxi -o /out
```
