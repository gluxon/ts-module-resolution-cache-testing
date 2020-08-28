const fs = require("fs");
const path = require("path");

const NUM_BRANCHES = 50;
const CHAIN_LENGTH = 1000;

function* generateBranchAndChain() {
    for (const branch of [...new Array(NUM_BRANCHES)].keys()) {
        for (const chain of [...new Array(CHAIN_LENGTH)].keys()) {
            yield [branch, chain]
        }
    }
}

for (const [branch, chain] of generateBranchAndChain()) {
    const currentFn = `b${branch}c${chain}`;
    const nextFn = `b${branch}c${chain+1}`;

    const filePath = path.join(__dirname, "src", `${currentFn}.ts`)
    const fileBody = chain !== CHAIN_LENGTH - 1
        ? `import { ${nextFn} } from "./${nextFn}"; export const ${currentFn} = ${nextFn};`
        : `export function f${currentFn}(str: string) { console.log(str); }`;

    fs.writeFileSync(filePath, fileBody)
}

const indexBody = [...[...Array(NUM_BRANCHES)].keys()]
    .map(branch => `b${branch}c0`)
    .map(fnName => `export { ${fnName} } from "./${fnName}";`)
    .join("\n");
fs.writeFileSync(path.join(__dirname, "src/index.ts"), indexBody);