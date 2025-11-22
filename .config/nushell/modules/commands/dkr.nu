export def main [] { }

export def images [] {
  docker image ls --format '{{json .}}'
    | from json --objects
    | select Repository Tag ID Size CreatedSince
    | rename repository tag id size created
}

export def containers [] {
  docker container ls -a --format '{{json .}}' 
    | from json --objects 
    | select ID Image Names Ports Status Command RunningFor
    | rename id image name ports status command created
}
