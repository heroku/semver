process.env.NODE_ENV = 'test'

assert = require "assert"
semver = require "semver"
fs = require "fs"

Source = require "../../lib/sources/node"
html = fs.readFileSync(__dirname + '/../fixtures/node.html').toString();

describe "Node Source", ->

  describe "default properties", ->

    before ->
      this.s = new Source()

    it "defaults to empty all array", ->
      assert.equal this.s.all.length, 0

    it "default to empty stable array", ->
      assert.equal this.s.stable.length, 0

    it "defaults releases to the 'https://nodejs.org/download/release/' url", ->
      assert.equal this.s.releaseUrl, 'https://nodejs.org/download/release/'

    it "defaults release candidates to the 'https://nodejs.org/download/rc/' url", ->
      assert.equal this.s.candidateUrl, 'https://nodejs.org/download/rc/'

    it "has never been updated", ->
      assert.ok !this.s.updated

  describe "_parse()", ->

    before ->
      this.s = new Source()
      this.s._parse(html)

    it "has an array of all versions", ->
      assert.equal typeof(this.s.all), "object"
      assert.equal this.s.all.length, 219
      assert.equal this.s.all[214], '0.11.12'

    it "has an array of stable versions", ->
      assert.equal typeof(this.s.stable), "object"
      assert.equal this.s.stable.length, 108
      assert.equal this.s.stable[105], '0.10.29'

    it "includes v4.0.0 in stable", ->
      assert.ok(this.s.stable.indexOf('4.0.0') != -1)

    it "has been updated", ->
      assert.ok this.s.updated
