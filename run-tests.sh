#!/usr/bin/env bash

TESTS_FAILED=0


test_output() {
  local command=$1;
  local expected_output=$2;

  local output=`$command`;

  echo "Testing: '$command' Produces: '$output'"

  if [[ $output == $expected_output ]]; then
    echo "OK"
  else
    echo "NOT OK"
    TESTS_FAILED=$((TESTS_FAILED + 1))
  fi
}


test_output "./hello-world" "Hello World!"
test_output "./hello-world --shout" "HELLO WORLD!"
test_output "./hello-world --unknown" "The command '--unknown' is not supported"


if [[ $TESTS_FAILED -eq 0 ]]; then
    echo "All tests passed!"
    exit 0
else
    echo "$TESTS_FAILED tests failed!"
    exit 1
fi
