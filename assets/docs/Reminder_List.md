<!-- TEMPLATE for TABLE:

## 2024-02-01
| Reminder | Description | Notes |
| -------- | ----------- | ----- |
| Holder for tomorrow: | Add a way to add new items to the devbook. |   |

 -->

# Reminders

## 2024-02-01

| Reminder | Description | Notes |
| -------- | ----------- | ----- |
| Holder for tomorrow: | Add a way to add new items to the devbook. |   |

## 2024-01-31

| Reminder                                                          | Description                                                          | Notes                                                                                                                                                                                                                                                   |
| ----------------------------------------------------------------- | -------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Marked for Operation                                              | Instead of `Marked for cleaning` Consider a `Marked for { purpose }` | Mark a section of code that needs to have a specific operation performed, for example, cleaned.                                                                                                                                                         |
| Appropriate Annotation                                            | Try to use similar annotations for similar purposes.                 | For example, `// ! ` can be used to mark something that should be changed **URGENTLY**, while `// + ` can be used to mark something that should be changed **IN OTHER PROJECTS**.                                                                       |
| Current Tags                                                      | Currently the tags within the extension: `better-comments` are:      | { ! : RED : URGENT Notes } <br/> { ? : WHITE : OTHER Notes} <br/> { + : YELLOW : NEW PROJECT NOTES } <br/> { // : STRIKE : EXTRA COMMENTS } <br/> { \* : GREEN : NOTES THAT SHOULD BE GOOD AS ARE } <br/> { - : Lilac : NEXT/CURRENT TASK }             |
| Tags and other settings can be changed in the settings.json file. | This can be found by doing any of the following:                     | 1. Open the file at its location: `C:/Users/Jjzet/AppData/Roaming/Code/User/settings.json` <br> 2. In VSCode, Press `CTRL + SHIFT + P` And search for settings. <br> 3. Go to an extension, like Better-Comments, and click the cog to modify settings. |

## 2024-01-30

| Reminder                                        | Description                                                                                                                                            | Notes                                                                                                             |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| Marked for Cleaning                             | Try to use the syntax `// ! Marked for { purpose }` to mark a section of code that needs to have a specific operation performed, for example, cleaned. |
| Clean the Server Codebase                       | Clean up the server codebase to be more readable and easier to use.                                                                                    | PostCategories is the first to be cleaned. Goals was second. Posts was third. These should all be checked though. |
| Files on the right side of the screen are good. | These include: Where I am modifying the tests to be run, the ErrorLog model, and the PostCategories Handler. As well as the current log.               |                                                                                                                   |

## 2024-01-25

| Reminder              | Description                                             | Notes                                         |
| --------------------- | ------------------------------------------------------- | --------------------------------------------- |
| Added Utility Service | Added a new function to get a utility by name.          |                                               |
| Added WriteToLogFile  | Added the WriteToLogFile function to the BaseLog class. |                                               |
| Added readJson        | Added the readJson function to the BaseLog class.       |                                               |
| Added LogConfig       | Added the LogConfig class.                              | Might Remove this.                            |
| NavBar Tests          | Added Tests to the NavBar                               | Output Tests directory `/server/tests/output` |
