;extends

(image_spec
  name: (image_name) @image.name)

(image_spec
  tag: (image_tag) @image.tag
  (#offset! @image.tag 0 1 0 0))

(from_instruction as: (image_alias) @image.alias)
