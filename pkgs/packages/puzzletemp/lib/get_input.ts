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

function has_class(tag: string, class_name: string): boolean {
  const class_match = tag.match(/\bclass\s*=\s*(["'])(.*?)\1/i);

  if (!class_match) {
    return false;
  }

  return class_match[2].split(/\s+/).includes(class_name);
}

function find_last_div_with_class(
  source: string,
  class_name: string,
  end_index: number,
) {
  const div_tags = source.slice(0, end_index).matchAll(/<div\b[^>]*>/gi);
  let last_match: RegExpMatchArray | undefined;

  for (const div_tag of div_tags) {
    if (has_class(div_tag[0], class_name)) {
      last_match = div_tag;
    }
  }

  return last_match;
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
    const pre_blocks = source.matchAll(/<pre\b[^>]*>([\s\S]*?)<\/pre>/gi);

    for (const pre_block of pre_blocks) {
      const pre_index = pre_block.index ?? 0;
      const title_div = find_last_div_with_class(source, "title", pre_index);

      if (!title_div || title_div.index === undefined) {
        continue;
      }

      const title_text = normalize_input(
        strip_tags(source.slice(title_div.index + title_div[0].length, pre_index)),
      );

      if (!/^Input/i.test(title_text)) {
        continue;
      }

      const input_div = find_last_div_with_class(source, "input", title_div.index);

      if (!input_div) {
        continue;
      }

      const input = normalize_input(extract_pre_text(pre_block[1]));

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
