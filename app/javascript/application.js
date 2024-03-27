// Entry point for the build script in your package.json
import { Turbo } from '@hotwired/turbo-rails';
import '@rails/actiontext';
import 'trix';
import '@splidejs/splide';
import 'tributejs';
import 'mermaid';

import './trix-content';
import './mention';
import './navbar-burger';
import './tabs';
import './pageloader';
import './show-more-icons';
import './line-select';
import './size-select';
import './clipboard';
import './knowledge-carousel';
import './knowledge-mermaid';
import './home-search';
import './file-preview';
import './color-picker';
import './price-histogram';
import 'choices.js';

Turbo.session.drive = false;
