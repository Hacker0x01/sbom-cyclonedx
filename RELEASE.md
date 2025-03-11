# Release

Keeping releases consistent is important so here are the steps to follow when pushing a new version.

1. Bump [lib/sbom/cyclone_dx/version.rb](https://github.com/Hacker0x01/sbom-cyclonedx/blob/main/lib/sbom/cyclone_dx/version.rb) to the next major.minor version
2. Make sure all tests are passing ```bundle && bundle exec rake && bundle exec rake appraisal spec```
3. Make sure [CHANGELOG](https://github.com/Hacker0x01/sbom-cyclonedx/blob/main/CHANGELOG.md) is up to date
4. Commit changes ```git commit -am "bumping to vX.X"```

 Changes committed:
  - Gemfile.lock
  - version.rb

5. Push to github ```git push origin/master```
6. Tag the version ```git tag -a vX.X -m 'Version X.X Stable' && git push --tags```
7. Build the gem ```gem build sbom-cyclone_dx.gemspec```
8. Push the gem to ruby gems ```gem push sbom-cyclone_dx-X.X.X.gem```
9. Remove the built gem locally ```rm sbom-cyclone_dx-X.X.X.gem```
