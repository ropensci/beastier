context("java")

test_that("Windows experiments", {

  return()

  java1 <- "C:/Program Files (x86)/Java/jre1.8.0_181/bin/java.exe"
  java2 <- "/Users/Gebruiker/Documents/R/win-library/3.5/rJava/java"
  java3 <- "/Program Files (x86)/Common Files/Oracle/Java/javapath_target_3458765/java.exe"
  file.exists(java1)
  file.exists(java2)
  file.exists(java3)
  system2(java1, "-jar", get_default_beast2_jar_path(), stdout = TRUE)
  system2(java2, "-jar", get_default_beast2_jar_path(), stdout = TRUE)
  system2(java3, "-jar", get_default_beast2_jar_path(), stdout = TRUE)

  system2(java1, "-jar", get_default_beast2_jar_path(), stdout = TRUE)
  system2(java2, "-jar", get_default_beast2_jar_path(), stdout = TRUE)
  system2(java3, "-jar", get_default_beast2_jar_path(), stdout = TRUE)
})
