function decode_html_entities(value: string): string {
  const named_entities: Record<string, string> = {
    amp: "&",
    lt: "<",
    gt: ">",
    quot: '"',
    apos: "'",
    nbsp: " ",
  };

  return value.replace(/&(#x[0-9a-f]+|#\d+|[a-z]+);/gi, (match, entity) => {
    const lower_entity = entity.toLowerCase();

    if (lower_entity.startsWith("#x")) {
      return String.fromCharCode(Number.parseInt(lower_entity.slice(2), 16));
    }

    if (lower_entity.startsWith("#")) {
      return String.fromCharCode(Number.parseInt(lower_entity.slice(1), 10));
    }

    return named_entities[lower_entity] ?? match;
  });
}

function strip_tags(value: string): string {
  return value.replace(/<[^>]*>/g, "");
}

function normalize_input(value: string): string {
  return value.replace(/\r\n/g, "\n").replace(/\r/g, "\n").trim();
}

function extract_pre_text(pre_html: string): string {
  const example_lines = [...pre_html.matchAll(/<div\b[^>]*class="[^"]*\btest-example-line\b[^"]*"[^>]*>([\s\S]*?)<\/div>/gi)];

  if (example_lines.length > 0) {
    return example_lines
      .map((line) => decode_html_entities(strip_tags(line[1])))
      .join("\n");
  }

  const with_line_breaks = pre_html.replace(/<br\s*\/?>/gi, "\n");
  return decode_html_entities(strip_tags(with_line_breaks));
}

function get_codeforces_inputs(source: string): string[] {
  try {
    const inputs: string[] = [];
    const input_blocks = source.matchAll(
      /<div\b[^>]*class="[^"]*\binput\b[^"]*"[^>]*>[\s\S]*?<pre\b[^>]*>([\s\S]*?)<\/pre>[\s\S]*?<\/div>/gi,
    );

    for (const input_block of input_blocks) {
      const input = normalize_input(extract_pre_text(input_block[1]));

      if (input) {
        inputs.push(input);
      }
    }

    if (inputs.length === 0) {
      console.log("Couldn't find any Codeforces sample inputs.");
    }

    return inputs;
  } catch (error) {
    console.log("Couldn't find any Codeforces sample inputs.");
    return [];
  }
}

module.exports = {
  get_codeforces_inputs,
};
