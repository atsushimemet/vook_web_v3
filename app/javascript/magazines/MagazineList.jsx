import React, { useState, useEffect } from 'react'
import useSWR from 'swr'

const fetcher = (url) => fetch(url).then(res => res.json())

const MagazineCard = ({ magazine }) => (
  <div className="column is-one-quarter-tablet is-half-mobile">
    <div className="magazine-card card">
      <a href={`/magazine/${magazine.id}`}>
      <span className={`magazine-date ${magazine.status}`}>
        {magazine.publish_label}
      </span>
        <div className="magazine-card-image image is-square">
          <img
            src={magazine.thumbnail_url || '/assets/magazine-sample.webp'}
            alt={magazine.title}
            loading="eager"
          />
        </div>
        <div className="magazine-card-content">
          <div className="magazine-card-header">{magazine.title}</div>
        </div>
      </a>
    </div>
  </div>
)

const MagazineList = () => {
  const [page, setPage] = useState(1)
  const [magazines, setMagazines] = useState([])
  const [next, setNext] = useState(null)

  const { data, error } = useSWR(`/api/magazine?page=${page}`, fetcher)

  useEffect(() => {
    if (data?.magazines) {
      setMagazines((prev) => [...prev, ...data.magazines])
      setNext(data.next)
    }
  }, [data])

  const loadMore = () => {
    if (next) setPage(next)
  }

  if (error) return <p>現在、最新のMagazineを読み込めません</p>
  if (!data && magazines.length === 0) return <p>読み込み中...</p>

  return (
    <>
      <div className="magazine-cards columns is-mobile is-multiline">
        {magazines.map((magazine) => (
          <MagazineCard key={magazine.id} magazine={magazine} />
        ))}
      </div>
      {next && (
        <div className="has-text-centered">
          <a className="read-more-button" onClick={loadMore}>
            <i className="fa-solid fa-caret-down"></i>もっと読む
          </a>
        </div>
      )}
    </>
  )
}

export default MagazineList
