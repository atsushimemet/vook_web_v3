// Entry point for the build script in your package.json
import { Turbo } from '@hotwired/turbo-rails';
import '@rails/actiontext';
import Trix from 'trix';

import './trix-content';
import './navbar-burger';
import './tabs';
import './pagetop';
import './size-select';
import './clipboard';

Turbo.session.drive = false;
Trix.config.blockAttributes.default.tagName = 'p';
Trix.config.blockAttributes.heading1.tagName = 'h3';
