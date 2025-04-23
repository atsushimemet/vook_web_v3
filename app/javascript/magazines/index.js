import React from 'react'
import { createRoot } from 'react-dom/client'
import MagazineList from './MagazineList'

const rootEl = document.getElementById('magazine-list')
if (rootEl) {
  createRoot(rootEl).render(<MagazineList />)
}
