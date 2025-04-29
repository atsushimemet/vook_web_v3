import React, { useState, useEffect } from 'react'
import useSWR from 'swr'
import Skeleton from '@mui/material/Skeleton'

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
            fetchPriority="high"
          />
        </div>
        <div className="magazine-card-content">
          <div className="magazine-card-header">{magazine.title}</div>
        </div>
      </a>
    </div>
  </div>
)

const MagazineSkeleton = () => (
  <div className="column is-one-quarter-tablet is-half-mobile">
    <div className="magazine-card card">
      <div className="magazine-date">
        <Skeleton variant="text" width={80} height={16} />
      </div>
      <div className="magazine-card-image image">
        <Skeleton variant="rectangular" width="100%" height={0} style={{ paddingTop: '100%' }} />
      </div>
      <div className="magazine-card-content">
        <Skeleton variant="text" width="90%" height={24} />
      </div>
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
  if (!data && magazines.length === 0) {
    return (
      <div className="magazine-cards columns is-mobile is-multiline">
        {Array.from({ length: 8 }).map((_, i) => (
          <MagazineSkeleton key={i} />
        ))}
      </div>
    )
  }

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
