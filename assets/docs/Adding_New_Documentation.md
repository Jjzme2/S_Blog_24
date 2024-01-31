# Creating a Document for the Server Side Documentation

## What is a Document?

Documents are the bits of information we want to include for another developer, or ourselves, to understand how to use a specific part of the project.

### How do we write a Document?

Our documents are written in Markdown, a simple markup language that is easy to read and write.

### Where can we find the Documents?

Our documents are stored in the `assets/docs` folder.

## I've created a Document, now what?

Once you've created a document, and want to view it, you will need to go into the `DocService` file and add the document to the `docs` array.'
- Doc Service: `services\utilities\DocService.cfc`

### What is the `docs` array?

The `docs` array is an list of data that represents my **DOC** Object. Each object in the array should have the following properties:

<!-- Table -->
| Property | Type | Description |
| --- | --- | --- |
| id | String | A unique identifier for the document, Generally the name of the file, prefaced with `doc_`. |
| name | String | The name of the document, this is what will be displayed in the panel. |
| asHTML | String | This is using the `cbMarkdown` module to convert the markdown into HTML. |
| asMarkdown | String | This is the raw markdown read from the file. |
| link | String | This is the link to the document, this is what is used to navigate to the document. |
| created_on | Date | The date the document was created. |
| modified_on | Date | The date the document was last modified. |