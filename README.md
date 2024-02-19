## Trucking Nexus

## Summary:

Trucking Nexus is a Ruby on Rails application that serves as your one-stop destination for all things trucking-related. Whether you're a professional truck driver, an aspiring CDL (Commercial Driver's License) holder, or just an enthusiast looking to stay updated on the trucking industry, Trucking Nexus has you covered.

## Key Features:

- **Job Rating System:** Rate and review trucking jobs at different companies, helping fellow truckers make informed decisions about their career choices.

- **CDL Test Training:** Access comprehensive training materials and practice tests to prepare for your CDL exams, ensuring you're well-equipped for success.

- **Trip Planning (Not Available):** Plan your route with Google Maps API. Print completed DOT time sheets using the FMSCA time sheet form.

## Technologies Used:

- Ruby on Rails
- HTML/CSS (ERB & Tailwind.css)
- JavaScript (Stimulus JS)
- ActiveStorage image file uploading
- RSpec / Capybara for Testing

## Installation:

Copy Repository locally

Install Ruby >= `3.0.0`

Setup PostgeSQL

Bundle install

Start Server

## File Upload

Active Storage is using the `image_processing` gem
along with `mini_magick` gem, a lightweight wrapper around `imagemagick`.

This is used for generating variant images from attachables.
This can be changed via the `application.rb`.

Development is using local storage.
Production is using `Amazon S3`

## Usage:

Trucking Nexus is designed with simplicity in mind. Sign up, browse trucking job listings, rate your experiences, access CDL test prep materials, and stay informed about the trucking industry—all within a few clicks.

## Development

### Running Dev with Overmind

- `brew install tmux`
- `brew install overmind`

Start up development environment with command: `overmind start`

### Running Dev with Foreman

Start up development environment with command: `./bin/dev`

## Design

- **Quizzes:** [dbdiagrm.io Quizzes] (https://dbdiagram.io/d/testing-6512dd32ffbf5169f08733cb)

### Quizzes

## Contributing:

We welcome contributions from the trucking community and developers alike. Whether you want to suggest features, report bugs, or submit code improvements, please follow our [contribution guidelines on GitHub](link_to_contributing_guidelines).

## License:

Trucking Nexus is an open-source project released under the [license_name] license. See the [LICENSE](link_to_license_file) file for details.

## Contact:

- GitHub Repository: [Link to your GitHub repository]
- Email: [Your contact email address, if applicable]
- [Other contact methods if relevant, such as a website or social media]

## Demo:

## Screenshots:
