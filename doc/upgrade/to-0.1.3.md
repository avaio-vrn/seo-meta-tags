```
Seo::MetaTag.all.map{ |e| e.update_attributes(cnt: e.controller, ac: e.action, id_obj: e.id_obj, content_value: e.key_value) if e.content_value.blank? }
```
