#' Does Street Suffix Dictionary Return Any Matches
#'
#' @description Determine whether the street suffix dictionary returns any matches.
#'
#' @usage pm_streetSuf_any(.data, dictionary, locale = "us")
#'
#' @param .data A postmastr object created with \link{pm_prep}
#' @param dictionary Optional; a tbl created with \code{pm_dictionary} to be used
#'     as a master list for street suffixes. If none is specified, the full default
#'     street suffix dictionary will be used.
#' @param locale A string indicating the country these data represent; the only
#'    current option is \code{"us"} but this is included to facilitate future expansion.
#'
#' @return A logical scalar is returned that is \code{TRUE} if the data contains at
#'     least one street suffix name or abbrevation in the given dictionary and \code{FALSE}
#'     if they do not.
#'
#' @export
pm_streetSuf_any <- function(.data, dictionary, locale = "us"){

  # check for object and key variables
  if (pm_has_uid(.data) == FALSE){
    stop("The variable 'pm.uid' is missing from the given object. Create a postmastr object with pm_identify and pm_prep before proceeding.")
  }

  if (pm_has_address(.data) == FALSE){
    stop("The variable 'pm.address' is missing from the given object. Create a postmastr object with pm_prep before proceeding.")
  }

  # locale issues
  if (locale != "us"){
    stop("At this time, the only locale supported is 'us'. This argument is included to facilitate further expansion.")
  }

  # test dictionary
  if (missing(dictionary) == TRUE){
    .data <- pm_streetSuf_detect(.data, locale = locale)
  } else if (missing(dictionary) == FALSE){
    .data <- pm_streetSuf_detect(.data, dictionary = dictionary, locale = locale)
  }

  # create output
  out <- any(.data$pm.hasStreetSuf, na.rm = TRUE)

  # return output
  return(out)

}

#' Does Street Suffix Dictionary Return a Match for All Observations
#'
#' @description Determine whether the street suffix dictionary returns matches for all observations.
#'
#' @usage pm_streetSuf_all(.data, dictionary, locale = "us")
#'
#' @param .data A postmastr object created with \link{pm_prep}
#' @param dictionary Optional; a tbl created with \code{pm_dictionary} to be used
#'     as a master list for street suffixes. If none is specified, the full default
#'     street suffix dictionary will be used.
#' @param locale A string indicating the country these data represent; the only
#'    current option is \code{"us"} but this is included to facilitate future expansion.
#'
#' @return A logical scalar is returned that is \code{TRUE} if the data contains a street suffix
#'     name or abbreviation for every observation in the data set and \code{FALSE} otherwise.
#'
#' @export
pm_streetSuf_all <- function(.data, dictionary, locale = "us"){

  # check for object and key variables
  if (pm_has_uid(.data) == FALSE){
    stop("The variable 'pm.uid' is missing from the given object. Create a postmastr object with pm_identify and pm_prep before proceeding.")
  }

  if (pm_has_address(.data) == FALSE){
    stop("The variable 'pm.address' is missing from the given object. Create a postmastr object with pm_prep before proceeding.")
  }

  # locale issues
  if (locale != "us"){
    stop("At this time, the only locale supported is 'us'. This argument is included to facilitate further expansion.")
  }

  # test dictionary
  if (missing(dictionary) == TRUE){
    .data <- pm_streetSuf_detect(.data, locale = locale)
  } else if (missing(dictionary) == FALSE){
    .data <- pm_streetSuf_detect(.data, dictionary = dictionary, locale = locale)
  }

  # create output
  out <- all(.data$pm.hasStreetSuf, na.rm = TRUE)

  # return output
  return(out)

}

#' Detect Presence of Street Suffix
#'
#' @description Determine the presence of street suffix names or abbreviations
#'     at the end of a string.
#'
#' @usage pm_streetSuf_detect(.data, dictionary, locale = "us")
#'
#' @param .data A postmastr object created with \link{pm_prep}
#' @param dictionary Optional; a tbl created with \code{pm_dictionary} to be used
#'     as a master list for street suffixes. If none is specified, the full default
#'     street suffix dictionary will be used.
#' @param locale A string indicating the country these data represent; the only
#'    current option is \code{"us"} but this is included to facilitate future expansion.
#'
#' @return A tibble with a new logical variable \code{pm.hasStreetSuf} that is
#'     \code{TRUE} if a street suffix name or abbreviation from the given dictionary is
#'     found at the end of the address and \code{FALSE} otherwise.
#'
#' @importFrom dplyr %>%
#' @importFrom dplyr mutate
#' @importFrom stringr str_c
#' @importFrom stringr str_detect
#'
#' @export
pm_streetSuf_detect <- function(.data, dictionary, locale = "us"){

  # create bindings for global variables
  pm.address = NULL

  # check for object and key variables
  if (pm_has_uid(.data) == FALSE){
    stop("The variable 'pm.uid' is missing from the given object. Create a postmastr object with pm_identify and pm_prep before proceeding.")
  }

  if (pm_has_address(.data) == FALSE){
    stop("The variable 'pm.address' is missing from the given object. Create a postmastr object with pm_prep before proceeding.")
  }

  # locale issues
  if (locale != "us"){
    stop("At this time, the only locale supported is 'us'. This argument is included to facilitate further expansion.")
  }

  # load dictionary if not specified
  if (missing(dictionary) == TRUE){
    if (locale == "us"){
      dictionary <- pm_dictionary(type = "suffix")
    }
  }

  # minimize dictionary
  if (locale == "us"){
    dict <- paste(dictionary$suf.input, collapse = "|")
  }

  # check observations
  if (locale == "us"){
    .data <- dplyr::mutate(.data, pm.hasStreetSuf = stringr::str_detect(pm.address,
                                                                    pattern = stringr::str_c("\\b(", dict, ")\\b$")))
  }

  # return output
  return(.data)

}


#' Return Only Unmatched Observations From pm_streetSuf_detect
#'
#' @description Automatically subset the results of \link{pm_streetSuf_detect} to
#'    return only observations that were not found in the dictionary.
#'
#' @usage pm_streetSuf_none(.data, dictionary, locale = "us")
#'
#' @param .data A postmastr object created with \link{pm_prep}
#' @param dictionary Optional; a tbl created with \code{pm_dictionary} to be used
#'     as a master list for street suffixes. If none is specified, the full default
#'     street suffix dictionary will be used.
#' @param locale A string indicating the country these data represent; the only
#'    current option is \code{"us"} but this is included to facilitate future expansion.
#'
#' @importFrom dplyr %>%
#' @importFrom dplyr filter
#' @importFrom dplyr select
#'
#' @export
pm_streetSuf_none <- function(.data, dictionary, locale = "us"){

  # global bindings
  pm.hasStreetSuf = NULL

  # check for object and key variables
  if (pm_has_uid(.data) == FALSE){
    stop("The variable 'pm.uid' is missing from the given object. Create a postmastr object with pm_identify and pm_prep before proceeding.")
  }

  if (pm_has_address(.data) == FALSE){
    stop("The variable 'pm.address' is missing from the given object. Create a postmastr object with pm_prep before proceeding.")
  }

  # load dictionary if not specified
  if (missing(dictionary) == TRUE){
    if (locale == "us"){
      dictionary <- pm_dictionary(type = "suffix")
    }
  }

  # create output
  .data %>%
    pm_streetSuf_detect(dictionary = dictionary, locale = locale) %>%
    dplyr::filter(pm.hasStreetSuf == FALSE) %>%
    dplyr::select(-pm.hasStreetSuf) -> out

  # return output
  return(out)

}

#' Parse Street Suffix
#'
#' @description Parse a street suffix from a string. These data
#'     should be at the end of the string (i.e. the last word).
#'
#' @details If a street name is also a directional, like \code{North Ave}, it will be
#'     will have been parsed by \link{pm_streetDir_parse} so that only the street suffix
#'     remains (the directional element will be stored in \code{pm.preDir}. This function
#'     includes a logic check for streets that have a prefix direction but not street name
#'     after the street suffix is parsed. If those conditions are met, the street name
#'     will be changed from \code{NA} to the directional's preferred spelling according
#'     to the USPS.
#'
#' @usage pm_streetSuf_parse(.data, dictionary, locale = "us")
#'
#' @param .data A postmastr object created with \link{pm_prep}
#' @param dictionary Optional; a tbl created with \code{pm_dictionary} to be used
#'     as a master list for street suffixes. If none is specified, the full default
#'     street suffix dictionary will be used.
#' @param locale A string indicating the country these data represent; the only
#'    current option is "us" but this is included to facilitate future expansion.
#'
#' @importFrom dplyr %>%
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom stringr str_c
#' @importFrom stringr str_count
#' @importFrom stringr str_replace
#' @importFrom stringr word
#'
#' @export
pm_streetSuf_parse <- function(.data, dictionary, locale = "us"){

  # create bindings for global variables
  pm.address = pm.streetSuf = NULL

  # check for object and key variables
  if (pm_has_uid(.data) == FALSE){
    stop("The variable 'pm.uid' is missing from the given object. Create a postmastr object with pm_identify and pm_prep before proceeding.")
  }

  if (pm_has_address(.data) == FALSE){
    stop("The variable 'pm.address' is missing from the given object. Create a postmastr object with pm_prep before proceeding.")
  }

  # locale issues
  if (locale != "us"){
    stop("At this time, the only locale supported is 'us'. This argument is included to facilitate further expansion.")
  }

  # load dictionary if not specified
  if (missing(dictionary) == TRUE){
    if (locale == "us"){
      dictionary <- pm_dictionary(type = "suffix")
    }
  }

  # load dictionary if NULL
  if (is.null(dictionary) == TRUE){
    if (locale == "us"){
      dictionary <- pm_dictionary(type = "suffix")
    }
  }

  # parse street suffixes
  if (locale == "us"){
    .data <- pm_parse_suf_us(.data, dictionary = dictionary)
    vars <- pm_reorder(.data)
    .data <- dplyr::select(.data, vars)
  }

  # return output
  return(.data)

}

# parse American street suffixes
pm_parse_suf_us <- function(.data, dictionary, locale = "us"){

  # global bindings
  ...stDir = dir2.output = pm.preDir = pm.hasStreetSuf = NULL

  # minimize dictionary
  dict <- paste(dictionary$suf.input, collapse = "|")

  # create bindings for global variables
  pm.address = pm.streetSuf = NULL

  # detect directional streets
  if ("pm.preDir" %in% names(.data)){

    if ("pm.hasStreetSuf" %in% names(.data) == FALSE){
      .data <- pm_streetSuf_detect(.data, dictionary = dictionary, locale = locale)
      addedDetect <- TRUE
    } else if ("pm.hasStreetSuf" %in% names(.data) == TRUE){
      addedDetect <- FALSE
    }

    .data %>%
      dplyr::mutate(...stDir = ifelse(
        is.na(pm.preDir) == FALSE & stringr::str_count(pm.address, "\\w+") == 1,
        TRUE, FALSE)) %>%
      dplyr::mutate(pm.address = ifelse(...stDir == TRUE & pm.hasStreetSuf == TRUE,
        stringr::str_c(pm.preDir, " ", pm.address), pm.address)) %>%
      dplyr::mutate(pm.preDir = ifelse(...stDir == TRUE & pm.hasStreetSuf == TRUE, NA, pm.preDir)) -> .data

    if (addedDetect == TRUE){
      .data <- dplyr::select(.data, -pm.hasStreetSuf)
    }

  }

  # parse
  .data <- dplyr::mutate(.data, pm.streetSuf =
                           stringr::str_extract(pm.address,
                                                pattern = stringr::str_c("\\b(", dict, ")\\b$")))

  # clean address data
  .data %>%
    dplyr::mutate(pm.address = ifelse(is.na(pm.streetSuf) == FALSE, stringr::word(pm.address, start = 1, end = -1-stringr::str_count(pm.streetSuf, pattern = "\\w+")), pm.address)) %>%
    pm_streetSuf_std(var = pm.streetSuf, dictionary = dictionary) -> .data


  # clean directional street names
  if (locale == "us"){

    # create dictionary
    dict2 <- data.frame(
      dir2.input = c("N", "E", "S", "W", "NE", "NW", "SE", "SW"),
      dir2.output = c("North", "East", "South", "West", "Northeast", "Northwest", "Southeast", "Southwest"),
      stringsAsFactors = FALSE
    )

    # add dictionary column
    .data <- dplyr::left_join(.data, dict2, by = c("pm.address" = "dir2.input"))

    # replace
    .data %>%
      dplyr::mutate(pm.address = ifelse(is.na(dir2.output) == FALSE, dir2.output, pm.address)) -> .data

  }

}

#' Standardize Parsed Street Suffixes
#'
#' @description Convert street suffixes to USPS preferred abbreviation.
#'
#' @usage pm_streetSuf_std(.data, var, dictionary, locale = "us")
#'
#' @param .data A postmastr object created with \link{pm_prep}
#' @param var A character variable that may contain street suffixes
#' @param dictionary Optional; a tbl created with \code{pm_dictionary} to be used
#'     as a master list for street suffixes. If none is specified, the full default
#'     street suffix dictionary will be used.
#' @param locale A string indicating the country these data represent; the only
#'    current option is "us" but this is included to facilitate future expansion.
#'
#' @importFrom dplyr %>%
#' @importFrom dplyr left_join
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom dplyr rename
#' @importFrom rlang :=
#' @importFrom rlang enquo
#' @importFrom rlang quo
#' @importFrom rlang sym
#'
#' @export
pm_streetSuf_std <- function(.data, var, dictionary, locale = "us"){

  # save parameters to list
  paramList <- as.list(match.call())

  # unquote
  if (!is.character(paramList$var)) {
    varQ <- rlang::enquo(var)
  } else if (is.character(paramList$var)) {
    varQ <- rlang::quo(!! rlang::sym(var))
  }

  varQN <- rlang::quo_name(rlang::enquo(var))

  # locale issues
  if (locale != "us"){
    stop("At this time, the only locale supported is 'us'. This argument is included to facilitate further expansion.")
  }

  # load dictionary if not specified
  if (missing(dictionary) == TRUE){
    if (locale == "us"){
      dictionary <- pm_dictionary(type = "suffix")
    }
  }

  # standardize street suffix names
  if (locale == "us"){
    out <- pm_std_suf_us(.data, var = !!varQ, dictionary = dictionary)
  }

  # return output
  return(out)

}

# standardize us street suffixes
pm_std_suf_us <- function(.data, var, dictionary){

  # create bindings for global variables
  . = suf.input = suf.output = suf.type = NULL

  # save parameters to list
  paramList <- as.list(match.call())

  # unquote
  if (!is.character(paramList$var)) {
    varQ <- rlang::enquo(var)
  } else if (is.character(paramList$var)) {
    varQ <- rlang::quo(!! rlang::sym(var))
  }

  varQN <- rlang::quo_name(rlang::enquo(var))

  dictionary %>%
    dplyr::rename(!!varQ := suf.input) -> dictionary

  # standardize
  .data %>%
    dplyr::left_join(., dictionary, by = varQN) %>%
    dplyr::mutate(!!varQ := ifelse(is.na(suf.output) == FALSE, suf.output, !!varQ)) %>%
    dplyr::select(-suf.output, -suf.type) -> out

  # return output
  return(out)

}
