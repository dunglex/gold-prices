#!/usr/bin/env node

const fs = require('node:fs');
const path = require('node:path');

const goldInputPath = path.join(__dirname, '..', 'data', 'prices-btmc-vang.html');
const silverInputPath = path.join(__dirname, '..', 'data', 'prices-btmc-bac.html');
const outputPath = path.join(__dirname, '..', 'data', 'prices-baotinminhchau.json');

function decodeEntities(value) {
  const namedEntities = {
    amp: '&',
    apos: "'",
    gt: '>',
    lt: '<',
    nbsp: ' ',
    quot: '"'
  };

  return value.replace(/&(#x[\da-f]+|#\d+|[a-z]+);/gi, (entity, code) => {
    if (code[0] === '#') {
      const value = code[1].toLowerCase() === 'x'
        ? Number.parseInt(code.slice(2), 16)
        : Number.parseInt(code.slice(1), 10);
      return Number.isNaN(value) ? entity : String.fromCodePoint(value);
    }

    return namedEntities[code.toLowerCase()] ?? entity;
  });
}

function textFromHtml(value) {
  return decodeEntities(value)
    .replace(/<br\s*\/?>/gi, ' ')
    .replace(/<[^>]*>/g, '')
    .replace(/\s+/g, ' ')
    .trim();
}

function parsePrice(value) {
  const numericValue = value.trim();
  return /^\d+(?:\.\d+)?$/.test(numericValue)
    ? Number(numericValue) * 1000
    : null;
}

function parseTable(html, metal) {
  const table = html.match(/<table\b[^>]*\bclass=["'][^"']*\bbd_price_home\b[^"']*["'][^>]*>([\s\S]*?)<\/table>/i)?.[1];
  if (!table) {
    throw new Error(`BTMC ${metal}-price table was not found`);
  }

  const lastUpdated = parseLastUpdated(html, metal);
  const cellCount = metal === 'gold' ? 4 : 3;

  return [...table.matchAll(/<tr\b[^>]*>([\s\S]*?)<\/tr>/gi)]
    .map(([, row]) => [...row.matchAll(/<td\b[^>]*>([\s\S]*?)<\/td>/gi)]
      .map(([, cell]) => textFromHtml(cell)))
    .filter((cells) => cells.length >= cellCount)
    .map((cells) => {
      const values = cells.slice(-cellCount);
      const [name, buy, sell] = metal === 'gold'
        ? [values[0], values[2], values[3]]
        : values;
      const item = {
        metal,
        name,
        unit: 'VND',
        buy_price: parsePrice(buy),
        sell_price: parsePrice(sell),
        buy_price_text: buy,
        sell_price_text: sell,
        last_updated: lastUpdated
      };

      if (metal === 'gold') {
        item.content = values[1];
      }

      return item;
    });
}

function parseLastUpdated(html, metal) {
  const updateText = textFromHtml(
    html.match(/Cập nhật lúc\s*([^<]*)/i)?.[1] ?? ''
  );
  const updateMatch = updateText.match(/(\d{2})\/(\d{2})\/(\d{4})\s+(\d{2}:\d{2})/);

  if (!updateMatch) {
    throw new Error(`BTMC ${metal} update timestamp could not be parsed`);
  }

  const [, day, month, year, time] = updateMatch;
  return `${year}-${month}-${day} ${time}`;
}

const goldItems = parseTable(fs.readFileSync(goldInputPath, 'utf8'), 'gold');
const silverItems = parseTable(fs.readFileSync(silverInputPath, 'utf8'), 'silver');
const sources = [...goldItems, ...silverItems];

const result = {
  sources
};

fs.writeFileSync(outputPath, `${JSON.stringify(result, null, 2)}\n`);