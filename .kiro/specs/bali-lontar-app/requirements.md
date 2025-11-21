# Requirements Document

## Introduction

Bali Lontar is a mobile application designed to preserve and make accessible the ancient scripts of Bali and Java. The application provides OCR (Optical Character Recognition), transliteration, and translation capabilities for Aksara Bali and Aksara Kawi (Old Javanese) scripts. Users can capture images of lontar manuscripts, old books, signboards, or handwritten text, and convert them into readable Latin script or Indonesian language. The application serves scholars, students, cultural enthusiasts, and anyone interested in understanding historical Balinese and Javanese texts.

## Glossary

- **Bali Lontar App**: The mobile application system being developed
- **OCR Engine**: The optical character recognition component that converts script images to digital text
- **Transliteration Service**: The component that converts between different script systems
- **Dictionary Service**: The component that provides word-level translations
- **Aksara Bali**: The Balinese script system including standar, murda, and modre variants
- **Aksara Kawi**: The Old Javanese script system
- **Lontar**: Traditional palm leaf manuscripts
- **Pasangan**: Consonant conjuncts in Balinese script
- **Sandangan**: Diacritical marks in Balinese script
- **Storage Service**: The component managing saved OCR results and user data
- **Image Preprocessor**: The component that prepares images for OCR analysis

## Requirements

### Requirement 1

**User Story:** As a cultural researcher, I want to capture images of lontar manuscripts using my phone camera, so that I can digitize ancient texts in the field.

#### Acceptance Criteria

1. WHEN the user selects the camera option, THE Bali Lontar App SHALL activate the device camera with image capture controls
2. WHEN the user captures an image, THE Bali Lontar App SHALL save the image to temporary storage with timestamp metadata
3. THE Bali Lontar App SHALL support image selection from the device gallery as an alternative input method
4. WHEN an image is selected or captured, THE Bali Lontar App SHALL display a preview with options to proceed or retake
5. THE Bali Lontar App SHALL accept image formats including JPEG, PNG, and HEIC with maximum resolution of 4096x4096 pixels

### Requirement 2

**User Story:** As a student learning Balinese script, I want the app to automatically enhance unclear images, so that OCR accuracy improves for old or damaged manuscripts.

#### Acceptance Criteria

1. WHEN an image is submitted for OCR, THE Image Preprocessor SHALL convert the image to grayscale format
2. WHEN grayscale conversion completes, THE Image Preprocessor SHALL apply adaptive thresholding to separate text from background
3. WHEN thresholding completes, THE Image Preprocessor SHALL apply noise reduction filtering to remove artifacts
4. THE Image Preprocessor SHALL detect and correct image rotation within 15 degrees of horizontal alignment
5. WHEN preprocessing completes, THE Bali Lontar App SHALL display both original and processed images for user comparison

### Requirement 3

**User Story:** As a translator, I want the app to recognize Aksara Bali standar, murda, and modre variants, so that I can process different types of Balinese texts.

#### Acceptance Criteria

1. WHEN the OCR Engine processes an image, THE OCR Engine SHALL detect and classify Aksara Bali standar characters with minimum 85 percent accuracy
2. WHEN the OCR Engine processes an image, THE OCR Engine SHALL detect and classify Aksara Bali murda characters with minimum 80 percent accuracy
3. WHEN the OCR Engine processes an image, THE OCR Engine SHALL detect and classify Aksara Bali modre characters with minimum 80 percent accuracy
4. WHEN the OCR Engine processes an image, THE OCR Engine SHALL recognize pasangan consonant conjuncts and associate them with base characters
5. WHEN the OCR Engine processes an image, THE OCR Engine SHALL recognize sandangan diacritical marks and apply them to the correct base characters

### Requirement 4

**User Story:** As a historian, I want the app to recognize Aksara Kawi script, so that I can read Old Javanese manuscripts.

#### Acceptance Criteria

1. WHEN the OCR Engine processes an image with Kawi script, THE OCR Engine SHALL detect and classify basic Aksara Kawi characters with minimum 80 percent accuracy
2. WHEN the OCR Engine processes an image, THE OCR Engine SHALL distinguish between Aksara Bali and Aksara Kawi script systems automatically
3. WHEN the OCR Engine detects Aksara Kawi, THE Bali Lontar App SHALL apply Kawi-specific transliteration rules
4. THE OCR Engine SHALL recognize Kawi numerals and convert them to Arabic numerals
5. WHEN OCR completes, THE Bali Lontar App SHALL display the detected script type to the user

### Requirement 5

**User Story:** As a language learner, I want to convert Aksara Bali text to Latin script, so that I can read and pronounce Balinese words correctly.

#### Acceptance Criteria

1. WHEN the user requests Bali to Latin transliteration, THE Transliteration Service SHALL convert each Aksara Bali character to its Latin equivalent using the mapping rules
2. WHEN the Transliteration Service processes pasangan, THE Transliteration Service SHALL combine consonants according to Balinese phonetic rules
3. WHEN the Transliteration Service processes sandangan, THE Transliteration Service SHALL apply vowel modifications to the transliterated output
4. THE Transliteration Service SHALL preserve word boundaries and spacing from the original text
5. WHEN transliteration completes, THE Bali Lontar App SHALL display the Latin text with character-level alignment to the original script

### Requirement 6

**User Story:** As a teacher, I want to convert Latin text back to Aksara Bali, so that I can create educational materials in traditional script.

#### Acceptance Criteria

1. WHEN the user inputs Latin text for Bali transliteration, THE Transliteration Service SHALL convert each Latin character sequence to the corresponding Aksara Bali character
2. WHEN the Transliteration Service encounters consonant clusters, THE Transliteration Service SHALL generate appropriate pasangan forms
3. WHEN the Transliteration Service encounters vowel modifications, THE Transliteration Service SHALL apply the correct sandangan marks
4. THE Transliteration Service SHALL handle ambiguous Latin sequences by selecting the most common Aksara Bali representation
5. WHEN transliteration completes, THE Bali Lontar App SHALL render the Aksara Bali text using appropriate Unicode fonts

### Requirement 7

**User Story:** As a researcher, I want to convert Aksara Kawi to Latin script, so that I can analyze Old Javanese texts linguistically.

#### Acceptance Criteria

1. WHEN the user requests Kawi to Latin transliteration, THE Transliteration Service SHALL convert each Aksara Kawi character to its Latin equivalent using Kawi mapping rules
2. THE Transliteration Service SHALL handle Kawi-specific character variants that differ from Balinese script
3. WHEN transliteration completes, THE Bali Lontar App SHALL display the Latin text with annotations for ambiguous characters
4. THE Transliteration Service SHALL preserve punctuation marks and text formatting from the original Kawi text
5. WHEN the user requests Latin to Kawi transliteration, THE Transliteration Service SHALL convert Latin text to Aksara Kawi using reverse mapping rules

### Requirement 8

**User Story:** As a tourist, I want to translate Balinese text to Indonesian, so that I can understand signboards and cultural inscriptions.

#### Acceptance Criteria

1. WHEN the user requests Bali to Indonesian translation, THE Dictionary Service SHALL look up each Balinese word in the dictionary database
2. WHEN a word is found in the dictionary, THE Dictionary Service SHALL return the Indonesian translation with part of speech information
3. WHEN a word is not found in the dictionary, THE Dictionary Service SHALL return the original word with a not-found indicator
4. THE Dictionary Service SHALL support multi-word phrase lookup for common expressions
5. WHEN translation completes, THE Bali Lontar App SHALL display the Indonesian text with word-by-word alignment to the source

### Requirement 9

**User Story:** As a scholar, I want to translate Indonesian text to Balinese, so that I can create Balinese language content.

#### Acceptance Criteria

1. WHEN the user requests Indonesian to Bali translation, THE Dictionary Service SHALL look up each Indonesian word in the reverse dictionary database
2. WHEN multiple Balinese equivalents exist, THE Dictionary Service SHALL present all options with usage context
3. THE Dictionary Service SHALL handle Indonesian affixes and provide root word translations
4. WHEN translation completes, THE Bali Lontar App SHALL display the Balinese text with alternative word choices highlighted
5. THE Dictionary Service SHALL maintain a frequency-based ranking for common word translations

### Requirement 10

**User Story:** As an academic, I want to translate Kawi text to Indonesian, so that I can understand historical documents.

#### Acceptance Criteria

1. WHEN the user requests Kawi to Indonesian translation, THE Dictionary Service SHALL look up each Kawi word in the Kawi dictionary database
2. WHEN a Kawi word has archaic meanings, THE Dictionary Service SHALL provide both historical and modern Indonesian equivalents
3. THE Dictionary Service SHALL identify Sanskrit loanwords in Kawi text and provide etymological information
4. WHEN translation completes, THE Bali Lontar App SHALL display confidence scores for each word translation
5. THE Dictionary Service SHALL support partial word matching for damaged or unclear Kawi text

### Requirement 11

**User Story:** As a regular user, I want to save my OCR and translation results, so that I can reference them later without re-processing.

#### Acceptance Criteria

1. WHEN the user completes an OCR operation, THE Storage Service SHALL save the result with original image, recognized text, and timestamp
2. WHEN the user completes a transliteration, THE Storage Service SHALL save both source and target text with the operation type
3. WHEN the user completes a translation, THE Storage Service SHALL save the translation with source language and target language metadata
4. THE Storage Service SHALL assign a unique identifier to each saved result for retrieval
5. THE Bali Lontar App SHALL provide a history screen displaying all saved results in reverse chronological order

### Requirement 12

**User Story:** As a content creator, I want to export my results to text or PDF format, so that I can use them in other applications.

#### Acceptance Criteria

1. WHEN the user selects export to TXT, THE Bali Lontar App SHALL generate a plain text file containing the result text
2. WHEN the user selects export to PDF, THE Bali Lontar App SHALL generate a PDF document with formatted text and optional original image
3. THE Bali Lontar App SHALL include metadata in exported files including date, script type, and operation type
4. WHEN export completes, THE Bali Lontar App SHALL provide options to save to device storage or share via system share sheet
5. THE Bali Lontar App SHALL support batch export of multiple saved results to a single file

### Requirement 13

**User Story:** As a social media user, I want to share my transliteration results, so that I can discuss Balinese culture with my community.

#### Acceptance Criteria

1. WHEN the user selects the share option, THE Bali Lontar App SHALL invoke the system share interface with the result text
2. THE Bali Lontar App SHALL support sharing as plain text to messaging and social media applications
3. WHERE the result includes an image, THE Bali Lontar App SHALL support sharing both image and text together
4. THE Bali Lontar App SHALL allow the user to customize the shared text before sending
5. WHEN sharing completes, THE Bali Lontar App SHALL return the user to the result screen without data loss

### Requirement 14

**User Story:** As a user with limited connectivity, I want all core features to work offline, so that I can use the app in remote locations.

#### Acceptance Criteria

1. THE Bali Lontar App SHALL perform OCR operations without requiring internet connectivity
2. THE Transliteration Service SHALL operate entirely offline using local mapping data
3. THE Dictionary Service SHALL perform translations using local dictionary databases without internet access
4. THE Storage Service SHALL save and retrieve results using local device storage only
5. WHEN the device is offline, THE Bali Lontar App SHALL display all features as fully functional without degraded capability warnings

### Requirement 15

**User Story:** As a mobile user, I want a clean and intuitive interface, so that I can navigate the app easily without training.

#### Acceptance Criteria

1. THE Bali Lontar App SHALL implement Material Design 3 guidelines for visual consistency
2. THE Bali Lontar App SHALL use a color palette inspired by Balinese cultural aesthetics with warm earth tones
3. THE Bali Lontar App SHALL provide tab navigation for OCR, Transliteration, Translation, and History sections
4. WHEN the user performs any operation, THE Bali Lontar App SHALL display progress indicators with estimated completion time
5. THE Bali Lontar App SHALL support both light and dark themes based on system preferences

### Requirement 16

**User Story:** As a user processing multiple documents, I want to manage my saved results, so that I can organize and find specific translations.

#### Acceptance Criteria

1. WHEN the user views the history screen, THE Bali Lontar App SHALL display all saved results with thumbnail previews and titles
2. THE Bali Lontar App SHALL support search functionality to filter results by text content or date
3. WHEN the user selects a saved result, THE Bali Lontar App SHALL display the full result with options to re-export or delete
4. THE Bali Lontar App SHALL support deletion of individual results or batch deletion of multiple results
5. THE Storage Service SHALL maintain result integrity and prevent data corruption during delete operations

### Requirement 17

**User Story:** As a developer integrating the app, I want modular service architecture, so that I can extend or replace components independently.

#### Acceptance Criteria

1. THE Bali Lontar App SHALL implement OCR Engine as an independent service with defined input and output interfaces
2. THE Bali Lontar App SHALL implement Transliteration Service as an independent service with mapping data loaded from JSON files
3. THE Bali Lontar App SHALL implement Dictionary Service as an independent service with dictionary data loaded from JSON files
4. THE Bali Lontar App SHALL implement Storage Service as an independent service with abstract storage interface
5. THE Bali Lontar App SHALL use dependency injection to provide services to UI components

### Requirement 18

**User Story:** As a maintainer, I want comprehensive mapping data in JSON format, so that I can update transliteration rules without code changes.

#### Acceptance Criteria

1. THE Bali Lontar App SHALL load Aksara Bali to Latin mapping from a JSON file containing all character variants
2. THE Bali Lontar App SHALL load Aksara Kawi to Latin mapping from a separate JSON file with Kawi-specific rules
3. THE Bali Lontar App SHALL load Bali-Indonesian dictionary from a JSON file with word entries and definitions
4. THE Bali Lontar App SHALL load Kawi-Indonesian dictionary from a JSON file with archaic word entries
5. WHEN mapping files are updated, THE Bali Lontar App SHALL reload the data without requiring application reinstallation
