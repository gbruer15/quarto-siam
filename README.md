
# Quarto SIAM journal format

## Creating a New Article

To create a new article using this format:

```bash
quarto use template gbruer15/quarto-siam
```

This will create a new directory with an example document that uses this format.

## Using with an Existing Document

To add this format to an existing document:

```bash
quarto add gbruer15/quarto-siam
```

Then, add the format to your document options:

```yaml
format:
  siam-pdf: default
```    

## Options

*TODO*: If your format has options that can be set via document metadata, describe them.

## Example

*TODO*: Here is the source code for a minimal sample document: [template.qmd](template.qmd).

