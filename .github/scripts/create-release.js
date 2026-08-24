#!/usr/bin/env node

/*
 * Creates a GitHub release from the pull requests included between the
 * current and previous release tags.
 *
 * This script uses release-prs.js to identify the release pull requests,
 * validates their release labels, generates the release notes, and creates
 * the GitHub Release.
 */

const {
  releaseLabels
} = require('./release-config');

const {
  getReleasePrs
} = require('./release-prs');

async function main() {
  const currentTag = process.argv[2];

  if (!currentTag) {
    console.error(
      'Usage: create-release.js <release-tag>'
    );
    process.exit(1);
  }

  const token = process.env.GITHUB_TOKEN;

  if (!token) {
    console.error('GITHUB_TOKEN is required');
    process.exit(1);
  }

  const releasePrs = await getReleasePrs(
    currentTag,
    token
  );

  const invalidPrs = releasePrs.filter(
    pr => !pr.hasReleaseLabel
  );

  if (invalidPrs.length > 0) {
    console.error('');
    console.error('The following PRs have no valid release label:');

    for (const pr of invalidPrs) {
      console.error(
        `  #${pr.number} ${pr.title}`
      );

      console.error(
        `     Current labels: ${
          pr.labels.join(', ') || 'none'
        }`
      );
    }

    console.error('');
    console.error('Each PR must have at least one of:');

    for (const label of releaseLabels) {
      console.error(`  ${label}`);
    }

    process.exit(1);
  }

  console.log('');
  console.log('All release PRs have a valid release label.');
  console.log('');
  console.log('Release notes:');
  console.log('');

  for (const pr of releasePrs) {
    console.log(
      `- ${pr.title} (#${pr.number})`
    );
  }

  // GitHub Release creation will go here.
}

main().catch(error => {
  console.error(error.message);
  process.exit(1);
});
