import { execSync } from 'child_process'
import fs from 'fs'
import path from 'path'

import * as core from '@actions/core'

async function run(): Promise<void> {
  try {
    if (!process.env['GITHUB_WORKSPACE']) {
      throw new Error('GITHUB_WORKSPACE environment variable is not set')
    }

    if (!process.env['GITHUB_SHA']) {
      throw new Error('GITHUB_SHA environment variable is not set')
    }

    const docsDir = core.getInput('docsDir') || path.join(process.env['GITHUB_WORKSPACE'], 'doc')
    const tagVersionWithHash = !!core.getInput('tagVersionWithHash')

    core.debug(`docsDir = ${docsDir}`)
    core.debug(`tagVersionWithHash = ${tagVersionWithHash}`)

    core.startGroup('Locally install Rebar and Hex')
    execSync('mix local.rebar --force')
    execSync('mix local.hex --force')
    core.endGroup()

    core.startGroup('Install mix dependencies')
    execSync('mix deps.get')
    core.endGroup()

    if (tagVersionWithHash) {
      const mixPath = path.join(process.env['GITHUB_WORKSPACE'], 'mix.exs')
      core.debug(`mixPath = ${mixPath}`)

      const hash = process.env['GITHUB_SHA'].substring(0, 7)
      const mixText = fs
        .readFileSync(mixPath)
        .toString()
        .replace(/^(\s+)version: "([^"]+)",$/, `$1version: "$2+${hash}"`)

      core.debug(`vvvvv ${mixPath} vvvvv`)
      core.debug(mixText)
      core.debug(`^^^^^ ${mixPath} ^^^^^`)

      fs.writeFileSync(mixPath, mixText)
    }

    execSync(`mix docs --output ${docsDir}`)
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()
