fs = require 'fs'
path = require 'path'
yaml = require('js-yaml');
{spawn} = require 'child_process'

BuildStatusView = require './build-status-view'

module.exports =
  # Internal: The build status status bar entry view.
  buildStatusView: null

  # Internal: Active the package and initializes any views.
  #
  # Returns nothing.
  activate: ->
    return unless @isCodeshipProject() and @isGitHubRepo()

    @readCodeshipYaml()

    atom.workspaceView.command 'codeship-status:show-on-codeship', =>
      @showOnCodeship()

    createStatusEntry = =>
      @buildStatusView = new BuildStatusView(@config)

    if atom.workspaceView.statusBar
      createStatusEntry()
    else
      atom.packages.once 'activated', ->
        createStatusEntry()

  # Internal: Deactive the package and destroys any views.
  #
  # Returns nothing.
  deactivate: ->
    @buildStatusView?.destroy()

  # Internal: Serialize each view state so it can be restored when activated.
  #
  # Returns an object containing key/value pairs of view state data.
  serialize: ->

  # Internal: Get whether the project repository exists and is hosted on GitHub.
  #
  # Returns true if the repository exists and is hosted on GitHub, else false.
  isGitHubRepo: ->
    repo = atom.project.getRepo()
    return false unless repo?
    /(.)*github\.com/i.test(repo.getOriginUrl())

  # Internal: Check there is a .codeship.yml configuration file.
  #
  # Returns true if there is a .codeship.yml configuration file, else false.
  isCodeshipProject: ->
    return false unless atom.project.path?
    codeshipConf = path.join(atom.project.path, '.codeship.yml')
    fs.existsSync(codeshipConf)

  # Internal: Read the .codeship.yml configuration file
  #
  # Returns: nothing.
  readCodeshipYaml: ->
    return false unless atom.project.path?
    @config = yaml.safeLoad(fs.readFileSync(path.join(atom.project.path, '.codeship.yml'), 'utf8'));
