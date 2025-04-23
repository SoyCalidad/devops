#!/bin/bash
# set -x

main_directory="" # Format example: /home/master/odoo-modulos
own_version="17.0" # 17.0 by default | Set 17.0, 17-dev, 16.0, 16-dev, 15.0, 15-dev, 14.0, 14-dev, ...
odoo_version="17.0"
txt_own_repos="./repos.txt"
non_ent_repos="./list_enterprise_mod.csv"
dev_repos="False"
oca_repos="True" # True by default | Set True or False

if [ "$own_version" == "12-dev" ]; then
  odoo_version="12.0"
  dev_repos="True"
elif [ "$own_version" == "13-dev" ]; then
  odoo_version="13.0"
  dev_repos="True"
elif [ "$own_version" == "14-dev" ]; then
  odoo_version="14.0"
  dev_repos="True"
elif [ "$own_version" == "15-dev" ]; then
  odoo_version="15.0"
  dev_repos="True"
elif [ "$own_version" == "16-dev" ]; then
  odoo_version="16.0"
  dev_repos="True"
elif [ "$own_version" == "17-dev" ]; then
  odoo_version="17.0"
  dev_repos="True"
elif [ "$own_version" == "18-dev" ]; then
  odoo_version="18.0"
  dev_repos="True"
fi

function check_status_directory() {
  DIRECTORY="$1"
  if [[ -d "$DIRECTORY" ]]; then
    echo "$DIRECTORY exists on your filesystem."
  else
    mkdir "$DIRECTORY"
  fi
}

function check_status_odoo_repository() {
  DIRECTORY="$1"
  VERSION="$2"
  if [[ -d "$DIRECTORY/odoo" ]]; then
    echo "$DIRECTORY/odoo exists on your filesystem."
    git -C "$DIRECTORY/odoo" fetch origin
    git -C "$DIRECTORY/odoo" reset --hard origin/"$VERSION"
  else
    git -C "$DIRECTORY" pull -b "$VERSION" https://github.com/odoo/odoo.git odoo --depth 1
  fi
}

function check_status_oca_repositories() {
  OCA_MAIN_DIRECTORY="$1"
  MAIN_DIRECTORY="$2" 
  VERSION="$3"
  python3 "check_repos_oca.py" "${OCA_MAIN_DIRECTORY}" "$VERSION"
}

function check_status_own_repositories() {
  DIRECTORY="$1"
  FILE_REPOS="$2"
  VERSION="$3"

  while read line
  do
    MODULE=${line:33}
    FULL_PATH=$DIRECTORY/$MODULE
    if [[ -d "$FULL_PATH" ]]; then
      echo "* $FULL_PATH exists on your filesystem."
      git -C "$FULL_PATH" fetch origin
      git -C "$FULL_PATH" reset --hard origin/"$VERSION"
    else
      git -C "$DIRECTORY" pull -b "$VERSION" --depth 1 "$line"
      echo "Will pull repo: $MODULE"
    fi
  done < "$FILE_REPOS"
}

function check_status_non_ent_repositories() {
  NON_ENT_DIRECTORY="$1"
  OCA_MAIN_DIRECTORY="$2"
  NON_ENT_CSV="$3"
  VERSION="$4"
  ENTERPRISE_DIR="$OCA_MAIN_DIRECTORY/enterprise"

  if [[ -d $ENTERPRISE_DIR ]]; then
    while IFS=, read -r MOD_NAME_LINE MOD_NAME_VERSION
    do
      if [ "$VERSION" == "$MOD_NAME_VERSION" ]; then
        MODULE="$ENTERPRISE_DIR/$MOD_NAME_LINE"
        cp -r "$MODULE" "$NON_ENT_DIRECTORY"
        echo "Module $MOD_NAME_LINE was moved."
        if [ "$MOD_NAME_LINE" == "hr_payroll_account" ]; then
          old_text=", 'account_accountant'"
          new_text="    'depends': ['hr_payroll'],"
          sed -i "/$old_text/c\\$new_text" "$NON_ENT_DIRECTORY/$MOD_NAME_LINE/__manifest__.py"
          echo "enterprise dependency over $MOD_NAME_LINE was removed"
        fi
      fi
    done < "$NON_ENT_CSV"
  fi
}

odoo_base_directory="$main_directory"
odoo_version_directory="$odoo_base_directory/$odoo_version"
if [ "$dev_repos" == "True" ]; then
  odoo_base_own_directory="$odoo_version_directory/repos_dev"
else
  odoo_base_own_directory="$odoo_version_directory/repos"
fi
odoo_non_ent_directory="$odoo_version_directory/repos_non_ent"

echo "Creating: $odoo_version_directory"
check_status_directory "$odoo_version_directory"
echo "Creating: $odoo_non_ent_directory"
check_status_directory "$odoo_non_ent_directory"
echo "Creating: $odoo_base_own_directory"
check_status_directory "$odoo_base_own_directory"

check_status_odoo_repository "$odoo_version_directory" "$odoo_version"
check_status_own_repositories "$odoo_base_own_directory" "$txt_own_repos" "$own_version"
check_status_non_ent_repositories "$odoo_non_ent_directory" "$odoo_base_own_directory" "$non_ent_repos" "$odoo_version"

if [ "$oca_repos" == "True" ]; then
  odoo_base_oca_directory="$odoo_version_directory/repos_oca"
  echo "Creating: $odoo_base_oca_directory"
  check_status_directory "$odoo_base_oca_directory"
  check_status_oca_repositories "$odoo_base_oca_directory" "$main_directory" "$odoo_version"
fi
