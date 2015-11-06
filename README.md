# Codeship.com Status Package

Add the [Codeship.com](https://codeship.com) status of the project to the Atom status bar.

## Installing

Use the Atom package manager, which can be found in the Settings view or run
`apm install codeship-status` from the command line.

## Usage

The Codeship status for the repository is displayed via the clock-arrow icon
in the Atom status bar. The icon will be orange when Codeship is currently
building your project, green if the build was successfull and red if the build
failed.

The build status is updated when the project is first opened in Atom and from
then on whenever the "status" of the project repository changes. The handling of
these events was borrowed from the `git-view.coffee` part of the `status-bar`
package.

### Configuration

To be able to figure out the build status of the project, you have to create a
_.codeship.yml_ file in your project directory containing the UUID of the
Codeship project.

```yaml
# Sample .codeship.yml file
# (This is not a real UUID ;) )
uuid: abcdefgh-1234-ijkl-5678-mnopqrstuvwx
```

(You can find out the UUID of your project by going to the the _General_ tab of
your project settings.)

### Commands

The following commands are available for users to keymap.

* `codeship-status:toggle` - Toggle the status bar entry

## Coming Soon

* Open the project on Codeship.com
* Better support for multiple branches

Feel free to open an issue to discuss potential features to add or improve.

## Credits

This project is inspired and heavily based on the
[Travis CI Status Package](https://atomcodeshipcodeship.io/packages/travis-ci-status) by
[tombell](https://atomcodeshipcodeshipcodeship.io/users/tombell).
