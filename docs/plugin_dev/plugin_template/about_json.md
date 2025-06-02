# About.json
[about.json](about_json.md) file contains information about the Plugin

## Keys
```json title="about.json"
{
  "author": "",
  "release-notes": {
    "path": "",
    "version": ""
  },
  "credits": {},
  "comments": {},
  "copyright": "",
  "support": "",
  "acknowledgements": {},
}
```

| Name          | Description                                                                                                     |
|---------------|-----------------------------------------------------------------------------------------------------------------|
| author        | Author of the Plugin                                                                                            |
| release-notes | Containing information where the release note file is and what version the release notes are on (optional)                
| path          | The path to the release notes (optional)                                                                                  |
| version       | The version of the release notes (optional)                                                                               |
| credits       | Containing information about different sections that the Developer wants to credit (optional)                             |
| comments      | Containing comments that the developer wants to share. Those will be translated, so the language keys are needed (optional) |
| copyright     | Copyright of the Plugin (optional)                                                                                         |
| support       | General Support Website                                                                                         |
|acknowledgements| Sections that contain acknowledgements to people (optional)                                                                |

## Example About File
```json title="about.json"
{
  "author": "core447",
  "release-notes": {
    "path": "release_notes.notes",
    "version": "1.0.0"
  },
  "credits": {
    "Contributors": [
      "Core447",
      "G4PLS"
    ],
    "Assets": [
      "Core447"
    ]
  },
  "comments": {
    "en_US": "This about file is completely optional and most people will probably never even see the page where this gets displayed",
    "de_DE": "Die about datei ist komplett optional und wahrscheinlich werden sehr wenige überhaupt das Fenster sehen wo das hier angezeigt wird"
  },
  "copyright": "Copyright (C) 2024 Core447",
  "acknowledgements": {
    "Helpers": [
      "G4PLS"
    ]
  },
  "support": "https://github.com/StreamController/StreamController"
}
```

## Example Release Notes File
```html title="release_notes.notes"
<p>Only the listed things here are supported</p>

<p>Paragraphs are the most basic things</p>

<p>OL = Ordered list</p>
<ol>
    <li>List Items for the List, items will be displayed numbered</li>
</ol>

<p>UL= Unordered List</p>
<ul>
    <li>List Items for the List, items will be displayed with a "-"</li>
</ul>

<p><em>Used for emphesis inside Paragraphs, italic will be used</em></p>
<p><code>Used for inline code inside paragraphs, inline code will be shown in a monospaced font</code></p>
```
The file type does not matter for the relase notes file