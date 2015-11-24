require './dota_data'

template_for_single_callback =
    "
    {{callback_name}}First := true
    p.Callbacks.{{callback_name}}(func(m *dota.{{object_name}}) error {
        if {{callback_name}}First {
            fmt.Println(\"{{callback_name}}:\")
            data, _ := json.Marshal(m)
            fmt.Println(string(data))
            fmt.Println(\",\")
            {{callback_name}}First = false
        }
        return nil
    })"

template_for_all =
    "
    {{callback_name}}Count := 0
    p.Callbacks.{{callback_name}}(func(m *dota.{{object_name}}) error {
        fmt.Print(\"{{callback_name}}\")
        if {{callback_name}}Count > 0 {
            fmt.Print(string({{callback_name}}Count))
        }
        fmt.Print(\":\\n\")
        data, _ := json.Marshal(m)
        fmt.Println(string(data))
        fmt.Println(\",\")
        {{callback_name}}Count++
        return nil
    })"


string_regexp = /(?!\\)"(.*?)(?!\\)"(?!\\)/

def generate_doc_function template
  DocData.names.each do |name|
    puts template.gsub("{{callback_name}}", name.first).gsub("{{object_name}}", name.last)
  end
end

# generate_doc_function template_for_single_callback
generate_doc_function template_for_all