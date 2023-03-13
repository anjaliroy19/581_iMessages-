CodeEditor.availableLanguages
CodeEditor.availableThemes

struct ContentView: View {

    var body: some View {
        CodeEditor(source: "let a = 42")
    }
}

struct MyEditor: View {
  
    @State private var source   = "let it = be"
    @State private var language = CodeEditor.Language.swift

    var body: some View {
        Picker("Language", selection: $language) {
            ForEach(CodeEditor.availableLanguages) { language in
                Text("\(language.rawValue.capitalized)")
                    .tag(language)
            }
        }
    
        CodeEditor(source: $source, language: language)
    }
}

CodeEditor(source: $source, language: language, 
           flags: [ .selectable, .editable, .smartIndent ])
