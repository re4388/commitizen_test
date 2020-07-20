## `use commitizen`



- [commitizen/cz-cli: The commitizen command line utility. #BlackLivesMatter](https://github.com/commitizen/cz-cli)

- A CLI tool to provide us interactive prompt to commit with [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

- Let's install first

- ```bash
  npm install commitizen -g
  commitizen init cz-conventional-changelog --save-dev --save-exact

  // set below in your script package.json
  "commit": "npx git-cz"

  // all set shall be okay, time to commit
  git add .
  npm run commit


  ```
- it shall work now!


  ## Let's add `eslint`

- add this into your script

- ```
   "lint": "eslint --fix src/*.js"
  ```

- If you NPM global don't have eslint, run this `npm install eslint -g`

- run `eslint init` and choose reasonable options

- use below to config for `.eslintrc.json` for fast check. You can use double quote and eslint shall auto fix it after run it.

- ```
  {
      "env": {
          "browser": true,
          "es2020": true
      },
      "parserOptions": {
          "ecmaVersion": 11,
          "sourceType": "module"
      },
      "rules": {
          "quotes": [
              "error",
              "single"
          ]
      }
  }


  ```

- run `npm run lint` you can have `src/index.js` ready with double quote and linter will fix it.



## `Husky`
- [typicode/husky: Git hooks made easy 🐶 woof!](https://github.com/typicode/husky)

- Husky allow us easy use git-hook.

- Install it via `npm install husky --save-dev`

- Add below line into your package.json

  ```
    "husky": {
      "hooks": {
        "pre-push": "sh scripts/git-hook-prepush.sh"
      }
    },
  ```

- Add the `git-hook-prepush.sh` file in above path, we learned from this tutorial([維持團隊開發程式碼品質的好工具 — Git Hooks & Husky | by Sean Chou | 技術筆記 | Medium](https://medium.com/%E6%8A%80%E8%A1%93%E7%AD%86%E8%A8%98/%E7%B6%AD%E6%8C%81%E5%9C%98%E9%9A%8A%E9%96%8B%E7%99%BC%E7%A8%8B%E5%BC%8F%E7%A2%BC%E5%93%81%E8%B3%AA%E7%9A%84%E5%A5%BD%E5%B7%A5%E5%85%B7-git-hooks-husky-b4a0b11d3215))

  ```
  echo "[pre-push] Start prepush check"
  # Check for eslint
  echo "[pre-push] Check for NPM..."
  which npm &> /dev/null
  if [[ "$?" == 1 ]]; then
      echo "Please install NPM"
      exit 1
  fi
  echo "Pass for checking NPM"
  # Eslint check all files under src/
  echo "Eslint check all files under src/..."
  npm run lint
  if [[ "$?" == 1 ]]; then
      echo "ESlint check fail, abort git push"
      exit 1
  fi
  echo "Pass for Eslint check"
  echo "[pre-push] successfully"
  ```

- forget what is ``$?`, check [command line - What is `$?` ? Is it a variable? - Ask Ubuntu](https://askubuntu.com/questions/646526/what-is-is-it-a-variable)

- Then everything is set!

## The whole Work Flow Recap

- Say you made some change...

- go to index.js and add some line...

- and it's time to commit!

- ```
  git add .
  git status (check what files are at stage)
  npm run commit (via package.json script)
  ```

- Then you shall see interactive prompt to help us compile the commit convention.

- Next, we push to remote via `git push`

- We will see the pre-push hook activate via Husky, it will invoke linter to help us to lint!

- All Done!

## use Standard-version
- [conventional-changelog/standard-version: Automate versioning and CHANGELOG generation, with semver.org and conventionalcommits.org](https://github.com/conventional-changelog/standard-version)
- auto tag + auto changelog + auto bump version
- install it via `npm i --save-dev standard-version` and put below script in package.json
  ```
  {
    "scripts": {
      "release": "standard-version"
    }
  ```
- first release `npm run release -- --first-release`
- other release cli
  ```
  npm run release
  
  npm run release -- --prerelease

  npm run release -- --prerelease alpha

  # npm run script
  npm run release -- --release-as minor
  # Or
  npm run release -- --release-as 1.1.0
  ```


